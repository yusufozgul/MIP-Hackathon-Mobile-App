//
//  WeatherService.swift
//  mipHackathon
//
//  Created by Yusuf Özgül on 29.12.2019.
//  Copyright © 2019 Yusuf Özgül. All rights reserved.
//

import Foundation
import Alamofire

class GetWeather
{
    let urlString = "https://api.weather.com/v1/geocode/\("38.6140")/\("27.4296")/aggregate.json?apiKey=e45ff1b7c7bda231216c7ab7c33509b8&products=conditionsshort,fcstdaily10short,fcsthourly24short,nowlinks"
    
    private let icons = ["Tornado": "💨", "Tropical Storm" : "💨", "Hurricane" : "💨", "Strong Storms" : "⛈", "Thunder and Hail" : "⛈", "Rain to Snow Showers" : "🌨", "Rain / Sleet" : "🌨", "Wintry Mix Snow / Sleet" : "🌨", "Freezing Drizzle" : "🌨", "Freezing Rain" : "🌨", "Hail" : "🌨", "Sleet" : "🌨", "Drizzle" : "🌧", "Light Rain" : "🌧", "Rain" : "🌧", "Scattered Flurries" : "❄️", "Light Snow" : "❄️", "Blowing / Drifting Snow" : "❄️", "Snow" : "❄️", "Blowing Dust / Sandstorm" : "💨", "Foggy" : "💨", "Haze / Windy" : "💨", "Smoke / Windy" : "💨", "Breezy" : "💨", "Blowing Spray / Windy" : "💨", "Frigid / Ice Crystals" : "💨", "Cloudy" : "☁️", "Mostly Cloudy" : "🌥", "Partly Cloudy" : "⛅️", "Clear" : "☀️", "Sunny" : "☀️", "Fair / Mostly Clear" : "🌤", "Fair / Mostly Sunny" : "🌤", "Mixed Rain & Hail" : "🌨", "Hot" : "☀️", "Isolated Thunderstorms" : "🌦", "Thunderstorms" : "🌦", "Heavy Rain" : "🌧", "Heavy Snow" : "❄️", "Blizzard" : "❄️", "Not Available (N/A)" : "❔", "Scattered Showers" : "🌧", "Scattered Snow Showers" : "❄️", "Scattered Thunderstorms" : "⛈" , "" : "❔", "Showers" : "🌧", "Rain/Snow" : "🌧"]

    
    func get(completion: @escaping (ApiResult<[String]>) -> Void)
    {
        AF.request(urlString).responseData { (response) in
            
            switch response.result
            {
            case .success(let data):
                do
                {
                    let jsonDescoder = JSONDecoder()
                    let weather = try jsonDescoder.decode(WeatherResponse.self, from: data)

                    if let dayWeather = weather.fcsthourly24short?.forecasts?.first
                    {
                        print(dayWeather.iconName)
                        completion(.succes([self.icons[dayWeather.iconName ?? ""] ?? "", String((dayWeather.metric?.temp)!) + "°C"]))
                    }
                }
                catch
                {
                    completion(.error(errorType: .dataParseError))
                }
            case .failure(let error):
                completion(.error(errorType: .otherError))
            }
            
        }
    }
    
}


