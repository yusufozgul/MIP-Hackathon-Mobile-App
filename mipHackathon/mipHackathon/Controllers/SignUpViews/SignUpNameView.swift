//
//  SignUpNameView.swift
//  Wevent
//
//  Created by Yusuf Özgül on 18.08.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class SignUpNameView: UIView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameAreaView: UIView!
    
    @IBOutlet weak var surnameInfoLAbel: UILabel!
    @IBOutlet weak var surNameTextField: UITextField!
    @IBOutlet weak var surNameArea: UIView!
    
    
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    
    weak var delegate: SignUpDelegate?
    override func awakeFromNib()
    {
        contiuneLabel.text = "Devam"
        
        infoLabel.text = "Adınızı Giriniz"
        nameTextField.placeholder = "Adınız"
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        nameAreaView.layer.cornerRadius = 5
        nameAreaView.layer.masksToBounds = true
        nameAreaView.layer.borderColor = UIColor.lightGray.cgColor
        nameAreaView.layer.borderWidth = 1.0
        
        surNameArea.layer.cornerRadius = 5
        surNameArea.layer.masksToBounds = true
        surNameArea.layer.borderColor = UIColor.lightGray.cgColor
        surNameArea.layer.borderWidth = 1.0
        
        surnameInfoLAbel.text = "Soyadınızı Giriniz"

        surNameTextField.placeholder = "Soyadınız"
        surNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
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
        if !nameTextField.text!.isEmpty && !surNameTextField.text!.isEmpty
        {
            contiuneViewSetEnable()
        }
        else
        {
            contiuneViewSetDisable()
        }
    }
    @IBAction func tapContiune(_ sender: Any)
    {
        if contiuneView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        {
            delegate?.contiune()
            delegate?.sendData(eMail: nil, name: nameTextField.text!, surname: surNameTextField.text!, birthDate: nil, SignUpCitizenshipNumber: nil, passWord: nil, gender: nil, phoneNumber: nil, adress: nil)
        }
    }
}
