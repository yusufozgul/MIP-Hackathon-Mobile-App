//
//  FinishSignUpView.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class FinishSignUpView: UIView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextButtonLabel: UILabel!
    
    
    weak var delegate: SignUpDelegate?
    
    override func awakeFromNib()
    {
        nextButtonView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        nextButtonLabel.textColor = .white
    }
    @IBAction func finishSignUp(_ sender: Any)
    {
        delegate?.finishSignup()
    }
}
