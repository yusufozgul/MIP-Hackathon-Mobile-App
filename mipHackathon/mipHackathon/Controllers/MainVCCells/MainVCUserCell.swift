//
//  MainVCUserCell.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class MainVCUserCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 6
        bgView.backgroundColor = UIColor(red:0.39, green:0.55, blue:0.76, alpha:1.0)
        
        titleLabel.font = .TTNorms_Bold(size: 20)
        cityLabel.font = .TTNorms_Regular(size: 16)
        self.weatherLabel.text = ""
        
        GetWeather().get { (result) in
            switch result
            {
            case .succes(let data):
                self.weatherLabel.text = data[0] + " " + data[1]
            case .error(errorType: let type):
                print(type)
                break
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
