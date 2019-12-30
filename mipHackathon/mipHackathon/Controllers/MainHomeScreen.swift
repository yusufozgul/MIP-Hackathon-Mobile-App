//
//  MainHomeScreen.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class MainHomeScreen: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var newsData: [GetNewsResponseData] = []
    var eventData: [EventResponseData] = []
    var duyuruData: [DuyuruData] = []
    var formData: [FormData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("1", forKey: "USER_ID")
        
        GetNews().get { (result) in
            switch result
            {
            case .succes(let data):
                self.newsData = data
                self.tableView.reloadData()
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
            }
        }
        
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
        
        GetDuyuru().get { (result) in
            switch result
            {
            case .succes(let data):
                self.duyuruData = data
                self.tableView.reloadData()
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
            }
        }
        
        GetForms().get { (result) in
            switch result
            {
            case .succes(let data):
                self.formData = data
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

extension MainHomeScreen: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 3
        {
            if newsData.count >= 3
            {
                return 4
            }
            if newsData.count != 0
            {
                return 1 + newsData.count
            }
            else
            {
                return 0
            }
            
        }
        if section == 4
        {
            if eventData.count >= 3
            {
                return 4
            }
            if eventData.count != 0
            {
                return 1 + eventData.count
            }
            else
            {
                return 0
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mainUserCell", for: indexPath) as? MainVCUserCell
            {
                cell.titleLabel.text = "Günaydın Yusuf"
                cell.cityLabel.text =  "Manisa"
                return cell
            }
        }
        if indexPath.section == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mainAnnouncementCell", for: indexPath) as? MainVCAnnouncementCell
            {
                cell.titleLabel.text = "Duyurular"
                cell.descLabel.text = "\(duyuruData.count) adet okunmamış duyuru mevcut, göz atabilirsiniz."
                return cell
            }
        }
        if indexPath.section == 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mainPollCell", for: indexPath) as? MainVCPollCell
            {
                cell.titleLabel.text = "Anketler"
                cell.descLabel.text = "Size uygun \(formData.count) adet anket bulunuyor, hemem şimdi çözebilirsin."
                return cell
            }
        }
        if indexPath.section == 3
        {
            if indexPath.row == 0
            {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "mainNewsHeaderCell", for: indexPath) as? mainNewsHeaderCell
                {
                    cell.titleLabel.text = "Sizin İçin Haberler"
                    return cell
                }
            }
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MainNewCell", for: indexPath) as? MainNewCell
            {
                cell.titleLabel.text = newsData[indexPath.row - 1].name
                cell.descLabel.text = newsData[indexPath.row - 1].name.description
                return cell
            }
        }
        
        if indexPath.section == 4
        {
            if indexPath.row == 0
            {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "mainEventsHeaderCell", for: indexPath) as? mainEventsHeaderCell
                {
                    cell.titleLabel.text = "Etkinlikler"
                    return cell
                }
            }
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mainEventCell", for: indexPath) as? mainEventCell
            {
                cell.titleLabel.text = eventData[indexPath.row - 1].etkinlikName
                cell.descLabel.text = eventData[indexPath.row - 1 ].etkinlikLocation
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 3 && indexPath.row != 0
        {
            if let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as? MoovitVC
            {
                webView.url = newsData[indexPath.row - 1].url
                present(webView, animated: true)
            }
        }
        
        if indexPath.section == 1
        {
            if let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DuyuruVC") as? DuyuruVC
            {
                guard duyuruData.count != 0 else { return }
                webView.titleText = duyuruData[0].duyuruName
                webView.descText = duyuruData[0].duyuruContent
                webView.yazarText = duyuruData[0].yayin
                webView.dateText = duyuruData[0].date
                present(webView, animated: true)
            }
        }
        
        if indexPath.section == 2
        {
            if let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as? MoovitVC
            {
                guard formData.count != 0 else { return }
                webView.url = formData[0].formLink
                present(webView, animated: true)
            }
        }
    }
    
    
}
