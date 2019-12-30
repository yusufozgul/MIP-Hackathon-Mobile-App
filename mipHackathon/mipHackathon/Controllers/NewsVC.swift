//
//  NewsVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var newsData: [GetNewsResponseData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }

    func showError(message: String)
    {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

extension NewsVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainNewCell", for: indexPath) as? MainNewCell
        {
            cell.titleLabel.text = newsData[indexPath.row].name
            cell.descLabel.text = newsData[indexPath.row].name.description
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as? MoovitVC
        {
            webView.url = newsData[indexPath.row].url
            present(webView, animated: true)
        }
    }
    
}
