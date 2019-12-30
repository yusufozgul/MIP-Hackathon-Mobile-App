
//
//  SignUpGenderView.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import UIKit

class SignUpGenderView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var nextButtonView: UIView!
    @IBOutlet weak var nextButtonLabel: UILabel!
    
    weak var delegate: SignUpDelegate?
    
    override func awakeFromNib()
    {
        nextButtonLabel.text = "Devam"
        infoLabel.text = "Cinsiyetinizi Seçin"
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        nextButtonView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.3960784314, blue: 0.8980392157, alpha: 1)
        nextButtonLabel.textColor = .white
        
        nextButtonView.clipsToBounds = true
        nextButtonView.layer.cornerRadius = 5
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch row {
        case 0:
            return "Erkek"
        case 1:
            return "Kadın"
        case 2:
            return "Belirtmek İstemiyorum"
        default:
            return ""
        }
    }

    @IBAction func tapContiune(_ sender: Any)
    {
        delegate?.contiune()
        var gender: GenderTypes = .invalid
        switch genderPicker.selectedRow(inComponent: 0) {
        case 0:
            gender = .men
        case 1:
            gender = .women
        case 2:
            gender = .invalid
        default:
            gender = .invalid
        }
        
        
        delegate?.sendData(eMail: nil, name: nil, surname: nil, birthDate: nil, SignUpCitizenshipNumber: nil, passWord: nil, gender: gender, phoneNumber: nil, adress: nil)
    }
}
