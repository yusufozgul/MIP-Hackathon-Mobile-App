//
//  SignUpData.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation

struct SignUpData
{
    var eMail: String?
    var name: String?
    var surname: String?
    var birthDate: String?
    var SignUpCitizenshipNumber: String?
    var passWord: String?
    var phoneNumber: String?
    var gender: GenderTypes?
    var adress: AdressData?
}

struct SignInData
{
    var phoneNumber: String?
    var passWord: String?
}
