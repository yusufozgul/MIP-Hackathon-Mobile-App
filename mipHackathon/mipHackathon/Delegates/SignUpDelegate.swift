//
//  SignUpDelegate.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation

protocol SignUpDelegate: class
{
    func contiune()
    func sendData(eMail: String?, name: String?, surname: String?, birthDate: String?, SignUpCitizenshipNumber: String?, passWord: String?, gender: GenderTypes?, phoneNumber: String?, adress: AdressData?)
    func getLocation()
    func getNotification()
    func finishSignup()
}

enum GenderTypes: String
{
    case men = "male"
    case women = "female"
    case invalid = "other"
}

struct AdressData
{
    var city: String
    var district: String
    var neighborhood: String
    var street: String
    var doorNumber: String
}
