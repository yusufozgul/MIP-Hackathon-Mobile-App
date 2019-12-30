//
//  StarVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit


class StarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension StarVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StarViewCell", for: indexPath) as? StarViewCell
            {
                cell.titleLabel.text = "En Yakın Eczane"
                cell.bgView.backgroundColor = UIColor(red:0.44, green:0.49, blue:0.53, alpha:1.0)
                return cell
            }
        }
        if indexPath.row == 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StarViewCell", for: indexPath) as? StarViewCell
            {
                cell.titleLabel.text = "Borsa"
                cell.bgView.backgroundColor = UIColor(red:0.44, green:0.49, blue:0.53, alpha:1.0)
                return cell
            }
        }
        if indexPath.row == 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StarViewCell", for: indexPath) as? StarViewCell
            {
                cell.titleLabel.text = "Toplu Taşıma"
                cell.bgView.backgroundColor = UIColor(red:0.44, green:0.49, blue:0.53, alpha:1.0)
                return cell
            }
        }
        if indexPath.row == 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StarViewCell", for: indexPath) as? StarViewCell
            {
                cell.titleLabel.text = "Yakındaki Otoparklar"
                cell.bgView.backgroundColor = UIColor(red:0.44, green:0.49, blue:0.53, alpha:1.0)
                return cell
            }
        }
        if indexPath.row == 4
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "StarViewCell", for: indexPath) as? StarViewCell
            {
                cell.titleLabel.text = "Ring Noktaları"
                cell.bgView.backgroundColor = UIColor(red:0.44, green:0.49, blue:0.53, alpha:1.0)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 2
        {
            performSegue(withIdentifier: "goMoovitVC", sender: nil)
        }
        if indexPath.row == 1
        {
            performSegue(withIdentifier: "goExchangeVC", sender: nil)
        }
        if indexPath.row == 0
        {
            performSegue(withIdentifier: "goDutyPharmacy", sender: nil)
        }
        if indexPath.row == 3
        {
            performSegue(withIdentifier: "goMapView", sender: nil)
        }
        if indexPath.row == 4
        {
            performSegue(withIdentifier: "goRingVC", sender: nil)
        }
        
    }
    
}

