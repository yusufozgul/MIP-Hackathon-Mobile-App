
//
//  GetStocks.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetStocks
{
    func get(completion: @escaping (ApiResult<[ExchangeData]>) -> Void)
    {
        let urlString = "https://api.collectapi.com/economy/hisseSenedi"
        
        let header: HTTPHeaders = ["Authorization" : "apikey 7Ku7gtUGVnUmjvLPKGr5w2:2GS6KaK11XfbV5FvVrItuu"]
        
        AF.request(urlString, headers: header).responseData { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            let response = try jsonDecoder.decode(GetStocksResponse.self, from: data)
                            var responseData: [ExchangeData] = []
                            
                            for currency in response.result
                            {
                                let data = ExchangeData(name: currency.text, rate: String(currency.rate), value: currency.lastpricestr)
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

struct GetStocksResponse: Codable
{
    var result: [GetStocksResponseData]
}

struct GetStocksResponseData: Codable
{
    let rate, lastprice: Double
    let lastpricestr: String
    let hacim: Double
    let hacimstr, text, code: String
}

