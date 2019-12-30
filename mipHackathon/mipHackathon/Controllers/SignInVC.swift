//
//  SignInVC.swift
//  Wevent
//
//  Created by Yusuf Özgül on 25.09.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class SignInVC: UIViewController
{
    @IBOutlet weak var userNameInfoLabel: UILabel!
    @IBOutlet weak var userNameArea: UIView!
    @IBOutlet weak var userNameTextfield: UITextField!
    
    @IBOutlet weak var userPasswordInfo: UILabel!
    @IBOutlet weak var userPasswordArea: UIView!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var passwordVisibilityImage: UIImageView!
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    private var isVisible = true
    
    private var signInData = SignInData(phoneNumber: "", passWord: "")
    
    private var isMailVerify = false
    private var isPasswordVerify = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userNameArea.layer.cornerRadius = 5
        userNameArea.layer.masksToBounds = true
        userNameArea.layer.borderColor = UIColor.lightGray.cgColor
        userNameArea.layer.borderWidth = 1.0
        userNameArea.backgroundColor = .clear
        
        
        userPasswordArea.layer.cornerRadius = 5
        userPasswordArea.layer.masksToBounds = true
        userPasswordArea.layer.borderColor = UIColor.lightGray.cgColor
        userPasswordArea.layer.borderWidth = 1.0
        userPasswordArea.backgroundColor = .clear
        
        userPasswordTextField.isSecureTextEntry = true
        userPasswordTextField.addTarget(self, action: #selector(self.passwordTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        userNameTextfield.addTarget(self, action: #selector(self.userNameTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        userPasswordTextField.addTarget(self, action: #selector(self.passwordTextFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
        userNameTextfield.addTarget(self, action: #selector(self.userNameTextFieldDidChange(_:)), for: UIControl.Event.editingDidBegin)
        
        passwordVisibilityImage.image = UIImage(named: "visibilityON")
        passwordVisibilityImage.setImageColor(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        userNameInfoLabel.text = "Telefon Numaranız"
        userPasswordInfo.text = "Şifreniz"
        contiuneLabel.text = "Giriş Yap"
        
        setContiuneView()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        
    }
    
    func setContiuneView()
    {
        contiuneView.clipsToBounds = true
        contiuneView.layer.cornerRadius = 5
        contiuneViewSetDisable()
    }
    func contiuneViewSetEnable()
    {
        guard isMailVerify && isPasswordVerify else { return }
        contiuneView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        contiuneLabel.textColor = .white
    }
    func contiuneViewSetDisable()
    {
        contiuneLabel.textColor = #colorLiteral(red: 0.6705882353, green: 0.7137254902, blue: 0.7803921569, alpha: 1)
        contiuneView.backgroundColor = #colorLiteral(red: 0.1569802463, green: 0.1570138037, blue: 0.1569758356, alpha: 1)
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField)
    {
        isPasswordVerify = false
        contiuneViewSetDisable()
        
        isPasswordVerify = true
        contiuneViewSetEnable()
        
        return
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
    
    @objc func userNameTextFieldDidChange(_ textField: UITextField)
    {
        isMailVerify = false
        contiuneViewSetDisable()
        
        if textField.text != "" && textField.text!.count <= 30
        {
            isMailVerify = true
            contiuneViewSetEnable()
        }
    }
    
    @IBAction func tapPasswordVisibleButton(_ sender: Any)
    {
        if isVisible
        {
            userPasswordTextField.isSecureTextEntry = false
            isVisible = !isVisible
            passwordVisibilityImage.image = UIImage(named: "visibilityOFF")
        }
        else
        {
            userPasswordTextField.isSecureTextEntry = true
            isVisible = !isVisible
            passwordVisibilityImage.image = UIImage(named: "visibilityON")
        }
    }
    
    @IBAction func tapContiuneButton(_ sender: Any)
    {
        signin()
    }
    
    private func signin()
    {
        if contiuneView.backgroundColor == #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        {
            loadingActivity.isHidden = false
            contiuneLabel.isHidden = true
            
            signInData.passWord = userPasswordTextField.text!
            signInData.phoneNumber = userNameTextfield.text!
            
            SignInService().signUp(data: signInData) { (result) in
                self.loadingActivity.isHidden = true
                self.contiuneLabel.isHidden = false
                switch result
                {
                case .succes(let success):
                    if success
                    {
                        print("Success")
                    }
                    else
                    {
                        self.showError(message: "Giriş yapılamadı, bilgilerinizi kontrol edin.")
                    }
                case .error(errorType: let type):
                    self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
                }
            }
        }
    }
    
    func showError(message: String)
    {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func segueMainVC()
    {
        let eventPageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainContainerVC")
        eventPageVC.modalPresentationStyle = .fullScreen
        present(eventPageVC, animated: true)
    }
}

