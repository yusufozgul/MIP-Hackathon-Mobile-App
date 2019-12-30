//
//  GetDuyurular.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetDuyuru
{
    func get(completion: @escaping (ApiResult<[DuyuruData]>) -> Void)
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
                                        "duyuru_name": "Öğrencilerin Dikkatine",
                                        "duyuru_content": "04 Ocak 2020 Cumartesi günü başlayacak olan 2019-2020 Bilim ve Sanat Merkezleri Öğrenci Tanılama ve Yerleştirme Sürecinin ilk aşaması olan Grup Tarama Uygulamasına girecek öğrencilerin giriş belgeleri yayınlandı. Giriş belgeleri, öğrencinin devam ettiği okul idaresi tarafından e-okul sistemi sınav işlemleri modülü üzerinden verilecektir. Uygulamaya girecek öğrencilerin kimliklerini ve giriş belgelerini uygulama esnasında yanlarında bulundurmaları zorunludur.",
                                        "date": "29-12-2019",
                                        "yayin": "İsmail Akdeniz"
                                    }
                                ]
                            }
"""
                            let resData = string.data(using: .utf8)
                            if resData == nil { return }
                            let response = try jsonDecoder.decode(DuyuruResponse.self, from: resData!)
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

struct DuyuruResponse: Codable {
    let success: String
    let data: [DuyuruData]

    enum CodingKeys: String, CodingKey {
        case success
        case data = "Data"
    }
}

struct DuyuruData: Codable {
    let duyuruName, duyuruContent, date, yayin: String

    enum CodingKeys: String, CodingKey {
        case duyuruName = "duyuru_name"
        case duyuruContent = "duyuru_content"
        case date, yayin
    }
}
