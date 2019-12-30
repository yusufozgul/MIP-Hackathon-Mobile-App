//
//  SaveCategory.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class SaveTopicService
{
    private struct TopicData: Codable
    {
        var id: String
        var work: String
        var life: String
        var news: String
        var event: String
    }
    
    func save(work: [String], life: [String], news: [String], event: [String], completion: @escaping (ApiResult<Bool>) -> Void)
    {
        let urlString = ApiURL.base.rawValue + "/news/tag/"
        guard let userID = UserDefaults.standard.value(forKey: "USER_ID") as? String else { return }
        var createData = TopicData(id: userID, work: "", life: "", news: "", event: "")
        
        for w in work
        {
            createData.work += w + "*-*"
        }
        createData.work = String(createData.work.dropLast(3))
        for l in life
        {
            createData.life += l + "*-*"
        }
        createData.life = String(createData.life.dropLast(3))
        for n in news
        {
            createData.news += n + "*-*"
        }
        createData.news = String(createData.news.dropLast(3))
        for e in event
        {
            createData.event += e + "*-*"
        }
        createData.event = String(createData.event.dropLast(3))
        
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
                            if response.success == "1"
                            {
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

