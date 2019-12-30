//
//  Urls.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation

enum ApiURL: String
{
    case base = "http://ismailakdeniz.pythonanywhere.com"
    case signUp = "/user/register"
    case signIn = "/user/login/"
    case saveTopic = "/news/tag/"
}
