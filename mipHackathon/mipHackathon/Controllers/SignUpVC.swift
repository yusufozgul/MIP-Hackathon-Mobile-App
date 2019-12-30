//
//  SignUpVC.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var scrollerView: UIView!
    @IBOutlet weak var progressBar: UIView!
    
    let scrollView = UIScrollView()
    var signUpData = SignUpData()
    
    internal var currentPage = 0
    {
        didSet
        {
            UIView.animate(withDuration: 0.5) {
                self.progressBar.frame.size.width = UIScreen.main.bounds.width / 11 * CGFloat(self.currentPage)
            }
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        loadScrollView()
        progressBar.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func loadScrollView()
    {
        scrollView.frame = CGRect(x: 0, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        let nameView = loadNameView()
        nameView.frame = CGRect(x: scrollerView.frame.width * 0, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(nameView)
        
        let mailView = loadMailView()
        mailView.frame = CGRect(x: scrollerView.frame.width * 1, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(mailView)
        
        let birthView = loadBirthView()
        birthView.frame = CGRect(x: scrollerView.frame.width * 2, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(birthView)
        
        let passView = loadPasswordView()
        passView.frame = CGRect(x: scrollerView.frame.width * 3, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(passView)
        
        let citizenshipNumberView = loadCitizenshipNumberView()
        citizenshipNumberView.frame = CGRect(x: scrollerView.frame.width * 4, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(citizenshipNumberView)
        
        let phoneNumberView = loadPhoneNumberView()
        phoneNumberView.frame = CGRect(x: scrollerView.frame.width * 5, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(phoneNumberView)
        
        let genderView = loadGenderView()
        genderView.frame = CGRect(x: scrollerView.frame.width * 6, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(genderView)
        
        let adressView = loadAdressView()
        adressView.frame = CGRect(x: scrollerView.frame.width * 7, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(adressView)
        
        let topicView = loadTopicView()
        topicView.frame = CGRect(x: scrollerView.frame.width * 8, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(topicView)
        
        let privacyView = loadPrivacyView()
        privacyView.frame = CGRect(x: scrollerView.frame.width * 9, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(privacyView)
        
        let finishView = loadFinishView()
        finishView.frame = CGRect(x: scrollerView.frame.width * 10, y: 0, width: scrollerView.frame.width, height: scrollerView.frame.height)
        scrollView.addSubview(finishView)
        
        scrollView.contentSize.width = scrollerView.frame.width * 11
        scrollerView.addSubview(scrollView)
    }
    
    func loadNameView() -> UIView
    {
        if let nameView = UIView().loadNib(name: "SignUpNameView") as? SignUpNameView
        {
            nameView.delegate = self
            return nameView
        }
        return UIView()
    }
    
    func loadBirthView() -> UIView
    {
        if let birthView = UIView().loadNib(name: "SignUpBirthDateView") as? SignUpBirthDateView
        {
            birthView.delegate = self
            return birthView
        }
        return UIView()
    }
    
    func loadPasswordView() -> UIView
    {
        if let passView = UIView().loadNib(name: "SignUpPasswordView") as? SignUpPasswordView
        {
            passView.delegate = self
            return passView
        }
        return UIView()
    }
    
    func loadCitizenshipNumberView() -> UIView
    {
        if let citizenshipNumberView = UIView().loadNib(name: "SignUpCitizenshipNumberView") as? SignUpCitizenshipNumberView
        {
            citizenshipNumberView.delegate = self
            return citizenshipNumberView
        }
        return UIView()
    }
    
    func loadPhoneNumberView() -> UIView
    {
        if let view = UIView().loadNib(name: "phoneNumberView") as? phoneNumberView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
    func loadGenderView() -> UIView
    {
        if let view = UIView().loadNib(name: "SignUpGenderView") as? SignUpGenderView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
    
    func loadAdressView() -> UIView
    {
        if let view = UIView().loadNib(name: "SignUpAdressView") as? SignUpAdressView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
    
    func loadTopicView() -> UIView
    {
        if let view = UIView().loadNib(name: "SignUpKeyWordView") as? SignUpKeywordView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
    
    func loadMailView() -> UIView
    {
        if let view = UIView().loadNib(name: "SignUpMailView") as? SignUpMailView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
    
    func loadPrivacyView() -> UIView
    {
        if let view = UIView().loadNib(name: "PrivacyView") as? SignUpPrivacyView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
    
    func loadFinishView() -> UIView
    {
        if let view = UIView().loadNib(name: "FinishSignUpView") as? FinishSignUpView
        {
            view.delegate = self
            return view
        }
        return UIView()
    }
}

extension SignUpVC: SignUpDelegate
{
    func sendData(eMail: String?, name: String?, surname: String?, birthDate: String?, SignUpCitizenshipNumber: String?, passWord: String?, gender: GenderTypes?, phoneNumber: String?, adress: AdressData?)
    {
        if eMail != nil
        {
            signUpData.eMail = eMail
        }
        if name != nil
        {
            signUpData.name = name
        }
        if surname != nil
        {
            signUpData.surname = surname
        }
        if birthDate != nil
        {
            signUpData.birthDate = birthDate
        }
        if SignUpCitizenshipNumber != nil
        {
            signUpData.SignUpCitizenshipNumber = SignUpCitizenshipNumber
        }
        if passWord != nil
        {
            signUpData.passWord = passWord
        }
        if gender != nil
        {
            signUpData.gender = gender
        }
        if phoneNumber != nil
        {
            signUpData.phoneNumber = phoneNumber
        }
        if adress != nil
        {
            signUpData.adress = adress
        }
    }
    
    func contiune()
    {
        currentPage += 1
        scrollView.scrollToPage(index: currentPage)
        self.view.endEditing(true)
    }
    
    func getLocation()
    {
        
    }
    
    func getNotification()
    {
        
    }
    
    func finishSignup()
    {
        SignUpService().signUp(data: signUpData) { (result) in
            switch result
            {
            case .succes(let success):
                if success
                {
                    print("Success")
                }
                else
                {
                    self.showError(message: "Kayıt yapılamadı, bilgilerinizi kontrol edin.")
                }
            case .error(errorType: let type):
                self.showError(message: "Bir problem oluştu lütfen yeniden deneyin. Hata kodu: \(type.rawValue)")
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
}
