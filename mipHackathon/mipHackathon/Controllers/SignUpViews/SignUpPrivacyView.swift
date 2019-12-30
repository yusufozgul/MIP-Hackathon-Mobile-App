//
//  SignUpPrivacyView.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class SignUpPrivacyView: UIView {
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var nextView: UIView!
    @IBOutlet weak var nextLabel: UILabel!
    
    weak var delegate: SignUpDelegate?

    override func awakeFromNib()
    {
        nextView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        nextLabel.textColor = .white
        
        nextLabel.text = "Devam"
        
        locationView.layer.cornerRadius = 5
        notificationView.layer.cornerRadius = 5
    }

    @IBAction func getLocationAccess(_ sender: Any)
    {
        delegate?.getLocation()
    }
    @IBAction func getNotificationAcces(_ sender: Any)
    {
        delegate?.getNotification()
    }
    @IBAction func nextButton(_ sender: Any)
    {
        delegate?.contiune()
    }
}
