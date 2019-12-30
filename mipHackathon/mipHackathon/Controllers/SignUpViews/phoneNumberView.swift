//
//  phoneNumberView.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class phoneNumberView: UIView {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneAreaView: UIView!
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    
    weak var delegate: SignUpDelegate?
    private var isPasswordVerify = false
    
    override func awakeFromNib()
    {
        contiuneLabel.text = "Devam"
        
        infoLabel.text = "Telefon Numaranızı Girin"
        phoneTextField.placeholder = "Telefon Numaranız"
        phoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        phoneAreaView.layer.cornerRadius = 5
        phoneAreaView.layer.masksToBounds = true
        phoneAreaView.layer.borderColor = UIColor.lightGray.cgColor
        phoneAreaView.layer.borderWidth = 1.0
        setContiuneView()
    }
    
    func setContiuneView()
    {
        contiuneView.clipsToBounds = true
        contiuneView.layer.cornerRadius = 5
        contiuneViewSetDisable()
    }
    func contiuneViewSetEnable()
    {
        guard isPasswordVerify else { return }
        contiuneView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        contiuneLabel.textColor = .white
    }
    func contiuneViewSetDisable()
    {
        contiuneLabel.textColor = #colorLiteral(red: 0.6705882353, green: 0.7137254902, blue: 0.7803921569, alpha: 1)
        contiuneView.backgroundColor = #colorLiteral(red: 0.1569802463, green: 0.1570138037, blue: 0.1569758356, alpha: 1)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if textField.text?.count == 11
        {
            isPasswordVerify = true
            contiuneViewSetEnable()
        }
        else
        {
            isPasswordVerify = false
            contiuneViewSetDisable()
        }
        
    }
    @IBAction func tapContiune(_ sender: Any)
    {
        if contiuneView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        {
            delegate?.contiune()
            delegate?.sendData(eMail: nil, name: nil, surname: nil, birthDate: nil, SignUpCitizenshipNumber: nil, passWord: nil, gender: nil, phoneNumber: phoneTextField.text!, adress: nil)
        }
    }
}
