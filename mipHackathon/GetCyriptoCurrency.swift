//
//  GetCyriptoCurrency.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetCyriptoCurrency
{
    func get(completion: @escaping (ApiResult<[ExchangeData]>) -> Void)
    {
        let urlString = "https://api.collectapi.com/economy/cripto"
        
        let header: HTTPHeaders = ["Authorization" : "apikey 7Ku7gtUGVnUmjvLPKGr5w2:2GS6KaK11XfbV5FvVrItuu"]
        
        AF.request(urlString, headers: header).responseData { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            let response = try jsonDecoder.decode(GetCyriptoCurrencyResponse.self, from: data)
                            var responseData: [ExchangeData] = []
                            
                            for currency in response.result
                            {
                                let data = ExchangeData(name: currency.name, rate: currency.changeWeekstr, value: currency.pricestr)
                                responseData.append(data)
                            }
                            
                            completion(.succes(responseData))
                            
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

struct GetCyriptoCurrencyResponse: Codable
{
    var result: [GetCyriptoCurrencyResponseData]
}

struct GetCyriptoCurrencyResponseData: Codable
{
    let currency: String
    let changeWeek: Double
    let changeWeekstr: String
    let changeDay: Double
    let changeDaystr: String
    let changeHour: Double
    let changeHourstr, volumestr: String
    let volume: Int
    let pricestr: String
    let price: Double
    let circulatingSupply, marketCapstr: String
    let marketCap: Int
    let code, name: String
}
