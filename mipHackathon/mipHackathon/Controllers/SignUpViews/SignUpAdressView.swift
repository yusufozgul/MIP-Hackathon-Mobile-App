//
//  SignUpAdressView.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class SignUpAdressView: UIView {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextButtonLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityAreaView: UIView!
    
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var districtAreaView: UIView!

    @IBOutlet weak var neighborhoodTextField: UITextField!
    @IBOutlet weak var neighborhoodAreaView: UIView!
    
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var streetAreaView: UIView!
    
    @IBOutlet weak var doorNumberTextField: UITextField!
    @IBOutlet weak var doorNumberAreaView: UIView!
    
    weak var delegate: SignUpDelegate?
    
    override func awakeFromNib()
    {
        nextButtonLabel.text = "Devam"
        
        infoLabel.text = "Adres Bilgilerinizi Girin"
        
        cityTextField.placeholder = "Şehir"
        districtTextField.placeholder = "İlçe"
        streetTextField.placeholder = "Cadde veya Sokak"
        neighborhoodTextField.placeholder = "Mahalle"
        doorNumberTextField.placeholder = "Kapı Numarsı"
        
        nextButtonView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        nextButtonLabel.textColor = .white
        
        setBorder(view: cityAreaView)
        setBorder(view: districtAreaView)
        setBorder(view: neighborhoodAreaView)
        setBorder(view: streetAreaView)
        setBorder(view: doorNumberAreaView)
        
        nextButtonView.clipsToBounds = true
        nextButtonView.layer.cornerRadius = 5
    }
    
    func setBorder(view: UIView)
    {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
    }
    
    @IBAction func tapContiune(_ sender: Any)
    {
        delegate?.contiune()
        
        if cityTextField.text!.isEmpty
        {
            cityAreaView.shake()
            return
        }
        if districtTextField.text!.isEmpty
        {
            districtAreaView.shake()
            return
        }
        if neighborhoodTextField.text!.isEmpty
        {
            neighborhoodAreaView.shake()
            return
        }
        if streetTextField.text!.isEmpty
        {
            streetAreaView.shake()
            return
        }
        if doorNumberTextField.text!.isEmpty
        {
            doorNumberAreaView.shake()
            return
        }
        
        let adress = AdressData(city: cityTextField.text!,
                                district: districtTextField.text!,
                                neighborhood: neighborhoodTextField.text!,
                                street: streetTextField.text!,
                                doorNumber: doorNumberTextField.text!)
        
        delegate?.sendData(eMail: nil, name: nil, surname: nil, birthDate: nil, SignUpCitizenshipNumber: nil, passWord: nil, gender: nil, phoneNumber: nil, adress: adress)
    }
}
