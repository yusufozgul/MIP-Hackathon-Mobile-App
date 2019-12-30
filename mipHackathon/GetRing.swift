//
//  GetRing.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetRings
{
    func get(completion: @escaping (ApiResult<RingResponse>) -> Void)
    {
        let urlString = "http://ismailakdeniz.pythonanywhere.com/news/ring/"
        
        AF.request(urlString).responseString { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            
                            let resData = data.data(using: .utf8)
                            if resData == nil { return }
                            let response = try jsonDecoder.decode(RingResponse.self, from: resData!)
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

struct RingResponse: Codable {
    let parklar: [Ringler]

    enum CodingKeys: String, CodingKey
    {
        case parklar = "Parklar"
    }
}

struct Ringler: Codable {
    let lat, long: String
}
