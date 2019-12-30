//
//  GetForms.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetForms
{
    func get(completion: @escaping (ApiResult<[FormData]>) -> Void)
    {
        let urlString = "http://ismailakdeniz.pythonanywhere.com/news/duyurular/"
        
        AF.request(urlString).responseString { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            let string = """
{
    "success": "1",
    "Data": [
        {
            "form_adi": "form 1",
            "form_link": "https://docs.google.com/forms/d/1LWtBBdId3MrSzJT7zRL5aHqU1nMNhtbdMEFcTF-xonQ/viewform?edit_requested=true"
        }
    ]
}
"""
                            let resData = string.data(using: .utf8)
                            if resData == nil { return }
                            let response = try jsonDecoder.decode(FormsResponse.self, from: resData!)
                            completion(.succes(response.data))
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

struct FormsResponse: Codable {
    let success: String
    let data: [FormData]

    enum CodingKeys: String, CodingKey {
        case success
        case data = "Data"
    }
}

struct FormData: Codable {
    let formAdi: String
    let formLink: String

    enum CodingKeys: String, CodingKey {
        case formAdi = "form_adi"
        case formLink = "form_link"
    }
}
