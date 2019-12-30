//
//  EventService.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class EventService
{
    func get(completion: @escaping (ApiResult<[EventResponseData]>) -> Void)
    {
        let urlString = "http://ismailakdeniz.pythonanywhere.com/news/etkinlikler/"
        
        AF.request(urlString).responseString { (response) in

                    switch response.result
                    {
                    case .success(let data):
                        do
                        {
                            let jsonDecoder = JSONDecoder()
                            
                            let resData = data.data(using: .utf8)
                            if resData == nil { return }
                            let response = try jsonDecoder.decode(EventResponse.self, from: resData!)
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








struct EventResponse: Codable {
    let success: String
    let data: [EventResponseData]

    enum CodingKeys: String, CodingKey {
        case success
        case data = "Data"
    }
}


struct EventResponseData: Codable {
    let etkinlikName, etkinlikContent, etkinlikDate, etkinlikDescription: String
    let etkinlikLocation: String

    enum CodingKeys: String, CodingKey {
        case etkinlikName = "etkinlik_name"
        case etkinlikContent = "etkinlik_content"
        case etkinlikDate = "etkinlik_date"
        case etkinlikDescription = "etkinlik_description"
        case etkinlikLocation = "etkinlik_location"
    }
}
