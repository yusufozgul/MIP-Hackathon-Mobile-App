//
//  ProfileEditTopicsSearchResultCell.swift
//  WeventApp
//
//  Created by Yusuf Özgül on 25.11.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class ProfileEditTopicsSearchResultCell: UITableViewCell
{
    @IBOutlet weak var topicsLabel: UILabel!
    @IBOutlet weak var selectedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSelectedTopics()
    {
        selectedIcon.isHidden = false
        selectedIcon.setImageColor(color: .systemGreen)
    }
    
    func setUnselected()
    {
        selectedIcon.isHidden = true
    }

}
