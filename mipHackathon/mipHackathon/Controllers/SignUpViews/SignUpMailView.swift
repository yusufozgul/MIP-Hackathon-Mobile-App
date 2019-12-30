//
//  SignUpMailView.swift
//  Wevent
//
//  Created by Yusuf Özgül on 18.08.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class SignUpMailView: UIView
{
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var mailAreaView: UIView!
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    @IBOutlet weak var checkMailindicator: UIActivityIndicatorView!
    @IBOutlet weak var errorInfoLabel: UILabel!
    
    weak var delegate: SignUpDelegate?
    private var checkEmailString = ""
    
    override func awakeFromNib()
    {
        contiuneLabel.text = "Devam"
        
        mailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        infoLabel.text = "Mail Adresinizi Girin"
        mailTextField.placeholder = "Mail Adresiniz"
        mailTextField.keyboardType = .emailAddress
        
        errorInfoLabel.text = ""
        
        mailAreaView.layer.cornerRadius = 5
        mailAreaView.layer.masksToBounds = true
        mailAreaView.layer.borderColor = UIColor.lightGray.cgColor
        mailAreaView.layer.borderWidth = 1.0
        
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
        var textFieldText = ""
        for chracter in mailTextField.text!
        {
            if chracter != " "
            {
                textFieldText += String(chracter)
            }
        }
        mailTextField.text = textFieldText
        contiuneViewSetDisable()
        checkMailindicator.isHidden = true
        
        if isValidEmail(emailStr: mailTextField.text!)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7)
            {
                if self.checkEmailString == self.mailTextField.text
                {
                    self.checkMail()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkEmailString = self.mailTextField.text!
            }
        }
    }
    
    private func isValidEmail(emailStr: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func checkMail()
    {
        self.mailAreaView.layer.borderColor = UIColor.lightGray.cgColor
        self.errorInfoLabel.text = ""
        checkMailindicator.isHidden = false
    }
    
    func isValidMail(result: Bool, mail: String, errorMessage: String?)
    {
        if mail == mailTextField.text!
        {
            checkMailindicator.isHidden = true
            if result
            {
                contiuneViewSetEnable()
            }
            else
            {
                mailAreaView.shake()
                mailAreaView.layer.borderColor = UIColor.red.cgColor
                errorInfoLabel.text = errorMessage!
                errorInfoLabel.textColor = UIColor.red
            }
        }
    }
    
    @IBAction func tapContiune(_ sender: Any)
    {
        if contiuneView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        {
            delegate?.contiune()
            delegate?.sendData(eMail: mailTextField.text!, name: nil, surname: nil, birthDate: nil, SignUpCitizenshipNumber: nil, passWord: nil, gender: nil, phoneNumber: nil, adress: nil)
        }
    }
}
