//
//  ProfileVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController
{
    @IBOutlet weak var profileTableView: UITableView!
    

    var workTopics: [String] = []
    var lifeTopics:  [String] = []
    var newsTopics:  [String] = []
    var eventTopics:  [String] = []
    
    var workTopicsSelectable: [String] = ["Öğrenci", "Yazılım Müh", "Mekatronik Müh", "Elektirik Müh", "İşçi", "Yönetici", "CEO", "Personel", "Doktor", "İtfaiyeci"]
    
    var lifeTopicsSelectable:  [String] = ["Ascilik", "Bilgisayar Oyunları", "Resim", "Müzik", "Bilim", "E-Spor", "Yüzmek", "Bisiklet", "Kamp", "Balık Tutmak"]
    
    var newsTopicsSelectable:  [String] = ["Dünya", "Eğitim", "Ekonomi", "Moda", "Finans", "Otomobil", "Sağlık", "Spor", "Tatil", "Quiz", "Lezzet"]
    
    var eventTopicsSelectable:  [String] = ["Tiyatro", "Konser", "Festival", "E-Spor", "Spor"]
    
    
    var workCellTopics: [[String]] = []
    var lifeCellTopics:  [[String]] = []
    var newsCellTopics:  [[String]] = []
    var eventCellTopics:  [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if let data = UserDefaults.standard.value(forKey: "WORK") as? [String]
        {
            workTopics = data
        }
        if let data = UserDefaults.standard.value(forKey: "LIFE") as? [String]
        {
            lifeTopics = data
        }
        if let data = UserDefaults.standard.value(forKey: "NEWS") as? [String]
        {
            newsTopics = data
        }
        if let data = UserDefaults.standard.value(forKey: "EVENT") as? [String]
        {
            eventTopics = data
        }
        
        DispatchQueue.main.async {
            self.workCellTopics = self.setTopics(inputArray: self.workTopics)
            self.lifeCellTopics = self.setTopics(inputArray: self.lifeTopics)
            self.newsCellTopics = self.setTopics(inputArray: self.newsTopics)
            self.eventCellTopics = self.setTopics(inputArray: self.eventTopics)
            self.profileTableView.reloadData()
        }
    }

    func setTopics(inputArray: [String]) -> [[String]]
    {
        var topicsArray: [String] = inputArray
        var outputArray: [[String]] = []
        while topicsArray.count != 0
        {
            var cellWordArray: [String] = []
            
            var widthValue: CGFloat = 0
            var count = 0
            for word in topicsArray
            {
                let label = UILabel()
//                label.font = .TTNorms_Medium(size: 16)
                label.text = word
                label.sizeToFit()
                let width = label.frame.size.width * 1.4 + 8
                
                count += 1
                
                guard  widthValue + width <= UIScreen.main.bounds.width - 48 else { break }
                widthValue += width
                
                cellWordArray.append(word)
                count -= 1
                topicsArray.remove(at: count)
            }
            outputArray.append(cellWordArray)
        }
        return outputArray
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        if section == 1
        {
            if workCellTopics.count == 0
            { return 2 }
            return workCellTopics.count + 1
        }
        if section == 2
        {
            if lifeCellTopics.count == 0
            { return 2 }
            return lifeCellTopics.count + 1
        }
        if section == 3
        {
            if newsCellTopics.count == 0
            { return 2 }
            return newsCellTopics.count + 1
        }
        if section == 4
        {
            if eventCellTopics.count == 0
            { return 2 }
            return eventCellTopics.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if let userCell = tableView.dequeueReusableCell(withIdentifier: "profileUserCell", for: indexPath) as? ProfileUserCell
            {
               return userCell
            }
        }
        
        if indexPath.section == 1
        {
            return getTopicCell(topics: workCellTopics, indexPath: indexPath, tableView: tableView, title: "İş Kategorileri")
        }
        
        if indexPath.section == 2
        {
            return getTopicCell(topics: lifeCellTopics, indexPath: indexPath, tableView: tableView, title: "Günlük Yaşam Kategorileri")
        }
        
        if indexPath.section == 3
        {
            return getTopicCell(topics: newsCellTopics, indexPath: indexPath, tableView: tableView, title: "Haber Kategorileri")
        }
        
        if indexPath.section == 4
        {
            return getTopicCell(topics: eventCellTopics, indexPath: indexPath, tableView: tableView, title: "Etkinlik Kategorileri")
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1 && indexPath.row == 0
        {
            if let topicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "topicSelectVC") as? ProfileEditTopicsVC
            {
                topicVC.delegate = self
                topicVC.fullTopics = workTopicsSelectable
                topicVC.type = "WORK"
                present(topicVC, animated: true)
            }
        }
        if indexPath.section == 2 && indexPath.row == 0
        {
            if let topicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "topicSelectVC") as? ProfileEditTopicsVC
            {
                topicVC.delegate = self
                topicVC.fullTopics = lifeTopicsSelectable
                topicVC.type = "LIFE"
                present(topicVC, animated: true)
            }
        }
        if indexPath.section == 3 && indexPath.row == 0
        {
            if let topicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "topicSelectVC") as? ProfileEditTopicsVC
            {
                topicVC.delegate = self
                topicVC.fullTopics = newsTopicsSelectable
                topicVC.type = "NEWS"
                present(topicVC, animated: true)
            }
        }
        if indexPath.section == 4 && indexPath.row == 0
        {
            if let topicVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "topicSelectVC") as? ProfileEditTopicsVC
            {
                topicVC.delegate = self
                topicVC.fullTopics = eventTopicsSelectable
                topicVC.type = "EVENT"
                present(topicVC, animated: true)
            }
        }
    }
    
    func getTopicCell(topics: [[String]], indexPath: IndexPath, tableView: UITableView, title: String) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = UITableViewCell()
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = title
            cell.textLabel?.font = .TTNorms_Medium(size: 18)
            cell.textLabel?.numberOfLines = 0
            cell.contentView.layoutMargins.left = 24
            return cell
        }
        if indexPath.row > 0 && indexPath.row <= topics.count
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "profileAboutDetailTopicsCell", for: indexPath) as? ProfileAboutDetailTopicsCell
            {
                cell.setView(keywordsArray: topics[indexPath.row - 1])
                return cell
            }
        }
        else if indexPath.row == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "profileAboutDetailTopicsCellInfo", for: indexPath) as? profileAboutDetailTopicsCellInfo
            {
                cell.infoLabel.text = "Lütfen kategori ekleyin"
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ProfileVC: TopicDelegate
{
    func reload() {
        viewDidAppear(true)
    }
    
    func save(topics: [String], type: String)
    {
        UserDefaults.standard.set(topics, forKey: type)
        
        SaveTopicService().save(work: workTopics, life: lifeTopics, news: newsTopics, event: eventTopics) { (_) in }
    }
}
