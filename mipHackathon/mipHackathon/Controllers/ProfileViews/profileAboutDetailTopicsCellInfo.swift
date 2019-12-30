//
//  profileAboutDetailTopicsCellInfo.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class profileAboutDetailTopicsCellInfo: UITableViewCell
{
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var badgeBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        badgeBG.layer.cornerRadius = badgeBG.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
