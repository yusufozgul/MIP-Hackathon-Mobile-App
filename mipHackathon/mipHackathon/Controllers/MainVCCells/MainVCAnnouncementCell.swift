//
//  MainVCAnnouncementCell.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class MainVCAnnouncementCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        bgView.layer.cornerRadius = 6
        bgView.backgroundColor = UIColor(red:0.38, green:0.62, blue:0.26, alpha:1.0)
    }

}
