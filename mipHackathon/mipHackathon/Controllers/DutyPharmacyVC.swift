//
//  DutyPharmacyVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit
import MapKit

class DutyPharmacyVC: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    var pharmacyData: [DutyPharmacyResponseData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        DutyPharmacy().get { (result) in
            switch result
            {
            case .succes(let data):
                self.pharmacyData = data
                self.tableView.reloadData()
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
            }
        }
    }
    
    func showError(message: String)
    {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

extension DutyPharmacyVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pharmacyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = pharmacyData[indexPath.row].name
        cell.detailTextLabel?.text = pharmacyData[indexPath.row].address + " - " + pharmacyData[indexPath.row].dist
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let actionSheet = UIAlertController(title: "İşlem Seçin", message: nil, preferredStyle: .actionSheet)
        
        let goMapsButton = UIAlertAction(title: "Yol tarifi al", style: .default) { (_) in
            
            let coordinates = self.pharmacyData[indexPath.row].loc.components(separatedBy: ",")
            let lat = Double(coordinates[0])
            let log = Double(coordinates[1])
            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: log ?? 0.0)))
            destination.name = self.pharmacyData[indexPath.row].name
            MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
        
        let call = UIAlertAction(title: "Arama Yap", style: .default) { (_) in
            if let phoneCallURL = URL(string: "telprompt://\(self.pharmacyData[indexPath.row].phone.replacingOccurrences(of: " ", with: ""))") {
                let application: UIApplication = UIApplication.shared
                if application.canOpenURL(phoneCallURL) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }
        
        let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        actionSheet.addAction(call)
        actionSheet.addAction(goMapsButton)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true)
    }
    
}
