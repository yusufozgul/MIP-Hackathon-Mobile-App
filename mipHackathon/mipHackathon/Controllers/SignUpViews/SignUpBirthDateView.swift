//
//  SignUpBirthDateView.swift
//  Wevent
//
//  Created by Yusuf Özgül on 18.08.2019.
//  Copyright © 2019 Ilao. All rights reserved.
//

import UIKit

class SignUpBirthDateView: UIView {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateAreaView: UIView!
    @IBOutlet weak var contiuneView: UIView!
    @IBOutlet weak var contiuneLabel: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    weak var delegate: SignUpDelegate?
    var datePicker: UIDatePicker?
    
    override func awakeFromNib()
    {
        infoLabel.text = "Doğum Tarihinizi Girin"
        dateTextField.placeholder = "Doğum Tarihiniz"
        contiuneLabel.text = "Devam"
        dateView.isHidden = true
        dateTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        dateTextField.textAlignment = .center
        
        dateAreaView.layer.cornerRadius = 5
        dateAreaView.layer.masksToBounds = true
        dateAreaView.layer.borderColor = UIColor.lightGray.cgColor
        dateAreaView.layer.borderWidth = 1.0
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.maximumDate = Date().addCurrentDate(value: -14, byAdding: "year")
        datePicker?.date = Date().addCurrentDate(value: -18, byAdding: "year")
        dateTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(self.dateChaged(datePicker: )), for: .valueChanged)
        
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

    @objc func dateChaged(datePicker: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        textFieldDidChange(dateTextField)
    }
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        if textField.text != ""
        {
            contiuneViewSetEnable()
            if let wordArray = textField.text?.components(separatedBy: " ")
            {
                guard wordArray.count == 3 else { return }
                dayLabel.text = wordArray[0]
                monthLabel.text = wordArray[1]
                yearLabel.text = wordArray[2]
                dateView.isHidden = false
            }
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
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let birthDate = dateFormatter.string(from: datePicker!.date)
            delegate?.sendData(eMail: nil, name: nil, surname: nil, birthDate: birthDate, SignUpCitizenshipNumber: nil, passWord: nil, gender: nil, phoneNumber: nil, adress: nil)
        }
    }
}
