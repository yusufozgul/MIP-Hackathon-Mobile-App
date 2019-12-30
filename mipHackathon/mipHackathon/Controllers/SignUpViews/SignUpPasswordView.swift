//
//  SignUpPasswordView.swift
//  Wevent
//
//  Created by Yusuf Özgül on 18.08.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class SignUpPasswordView: UIView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAreaView: UIView!
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    @IBOutlet weak var visibilityIcon: UIImageView!
    @IBOutlet weak var passwordInfoLabel: UILabel!
    
    weak var delegate: SignUpDelegate?
    private var isVisible = true
    private var isPasswordVerify = false
    
    override func awakeFromNib()
    {
        passwordInfoLabel.text = "Şifreniz minimum 8 karakter ve en az bir büyük ve küçük harf içermelidir."
        contiuneLabel.text = "Devam"
        
        infoLabel.text = "Şifre Belirleyiniz"
        passwordTextField.placeholder = "Şifreniz"
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextField.isSecureTextEntry = true
        visibilityIcon.image = UIImage(named: "visibilityON")
        visibilityIcon.setImageColor(color: UIColor.secondarySystemBackground)
        
        passwordAreaView.layer.cornerRadius = 5
        passwordAreaView.layer.masksToBounds = true
        passwordAreaView.layer.borderColor = UIColor.lightGray.cgColor
        passwordAreaView.layer.borderWidth = 1.0
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
    
    
    @IBAction func passwordVisibilityButton(_ sender: Any)
    {
        if isVisible
        {
            passwordTextField.isSecureTextEntry = false
            isVisible = !isVisible
            visibilityIcon.image = UIImage(named: "visibilityOFF")
        }
        else
        {
            passwordTextField.isSecureTextEntry = true
            isVisible = !isVisible
            visibilityIcon.image = UIImage(named: "visibilityON")
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        isPasswordVerify = false
        contiuneViewSetDisable()
        var upper = false
        var lower = false
        var digit = false
        
        guard textField.text!.count >= 8 else { return }
        
        for chracter in textField.text!
        {
            if chracter.uppercased() == String(chracter)
            {
                if !(chracter >= "a" && chracter <= "z") && !(chracter >= "A" && chracter <= "Z")
                {
                   upper = true
                }
            }
            
            if chracter.lowercased() == String(chracter)
            {
                if !(chracter >= "a" && chracter <= "z") && !(chracter >= "A" && chracter <= "Z")
                {
                   lower = true
                }
            }
            
            if let _ = Int(String(chracter))
            { digit = true }
        }
        
        guard upper, lower, digit else { return }
        isPasswordVerify = true
        contiuneViewSetEnable()
    }
    @IBAction func tapContiune(_ sender: Any)
    {
        if contiuneView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        {
            delegate?.contiune()
            delegate?.sendData(eMail: nil, name: nil, surname: nil, birthDate: nil, SignUpCitizenshipNumber: nil, passWord: passwordTextField.text!, gender: nil, phoneNumber: nil, adress: nil)
        }
    }
}
