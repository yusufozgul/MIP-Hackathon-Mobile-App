//
//  DutyPharmacy.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class DutyPharmacy
{
    func get(completion: @escaping (ApiResult<[DutyPharmacyResponseData]>) -> Void)
    {
        let urlString = "https://api.collectapi.com/health/dutyPharmacy?il=Manisa"
        
        let header: HTTPHeaders = ["Authorization" : "apikey 7Ku7gtUGVnUmjvLPKGr5w2:2GS6KaK11XfbV5FvVrItuu"]
        
        AF.request(urlString, headers: header).responseData { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            let response = try jsonDecoder.decode(DutyPharmacyResponse.self, from: data)
                            completion(.succes(response.result))
                            
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

struct DutyPharmacyResponse: Codable
{
    var result: [DutyPharmacyResponseData]
}

struct DutyPharmacyResponseData: Codable
{
    let name, dist, address, phone: String
    let loc: String
}
