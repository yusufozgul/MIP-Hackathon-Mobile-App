//
//  SignUpService.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class SignUpService
{
    private struct CreateData: Codable
    {
        var username: String
        var first_name: String
        var last_name: String
        var password: String
        var email: String
        var gender: String
    }
    
    func signUp(data: SignUpData, completion: @escaping (ApiResult<Bool>) -> Void)
    {
        let urlString = ApiURL.base.rawValue + ApiURL.signUp.rawValue
        let createData = CreateData(username: data.phoneNumber!, first_name: data.name!, last_name: data.surname!, password: data.passWord!, email: data.eMail!, gender: data.gender!.rawValue)
        
        AF.request(urlString,
                   method: .post,
                   parameters: createData,
                   encoder: URLEncodedFormParameterEncoder.default).responseData { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            let response = try jsonDecoder.decode(LoginResponse.self, from: data)
                            if response.success == "1" && response.id != nil
                            {
                                UserDefaults.standard.set(response.id, forKey: "USER_ID")
                                completion(.succes(true))
                            }
                            else
                            {
                                completion(.succes(false))
                            }
                        }
                        catch{
                            completion(.error(errorType: .dataParseError))
                        }

                    case .failure(let error):
                        if error.isResponseSerializationError
                        {
                            completion(.error(errorType: .serverError))
                        }
                        else
                        {
                            completion(.error(errorType: .internetError))
                        }
                    }
        }
    }
}

