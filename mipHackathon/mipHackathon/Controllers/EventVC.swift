//
//  EventVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class EventVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var eventData: [EventResponseData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
        EventService().get { (result) in
            switch result
            {
            case .succes(let data):
                self.eventData = data
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

extension EventVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mainEventCell", for: indexPath) as? mainEventCell
        {
            cell.titleLabel.text = eventData[indexPath.row].etkinlikName
            cell.descLabel.text = eventData[indexPath.row].etkinlikLocation
            return cell
        }
        return UITableViewCell()
    }
    
    
}
