//
//  SignInService.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 28.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class SignInService
{
    private struct LoginData: Codable
    {
        var username: String
        var password: String
    }
    
    func signUp(data: SignInData, completion: @escaping (ApiResult<Bool>) -> Void)
    {
        let urlString = ApiURL.base.rawValue + ApiURL.signIn.rawValue
        let createData = LoginData(username: data.phoneNumber ?? "", password: data.passWord ?? "")
        
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

struct LoginResponse: Codable
{
    var success: String
    var id: String?
}
