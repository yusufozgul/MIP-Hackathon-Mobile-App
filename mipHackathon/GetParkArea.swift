//
//  GetParkArea.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetParkArea
{
    func get(completion: @escaping (ApiResult<ParkResponse>) -> Void)
    {
        let urlString = "http://ismailakdeniz.pythonanywhere.com/news/park/"

        
        AF.request(urlString).responseData { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            let response = try jsonDecoder.decode(ParkResponse.self, from: data)
                            completion(.succes(response))
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

struct ParkResponse: Codable {
    let parklar: [Parklar]

    enum CodingKeys: String, CodingKey
    {
        case parklar = "Parklar"
    }
}

struct Parklar: Codable {
    let lat, long: String
}
