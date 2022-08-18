//
//  Wether.swift
//  URLSessionHomeworkApp
//
//  Created by Дмитрий Дуров on 08.08.2022.
//


enum Link: String {
    case weatherURL = "https://goweather.herokuapp.com/weather/Moscow"
}

struct Weather {
    let temperature: String
    let wind: String
    let description: String
    var forecast: [Forecast]
    
    init(value: [String: Any]) {
        temperature = value["temperature"] as? String ?? ""
        wind = value["wind"] as? String ?? ""
        description = value["description"] as? String ?? ""
        forecast = []
        for key in value {
            guard let forecastsDict = key.value as? [[String: String]] else { return }
            for forecastDict in forecastsDict {
                let forecastModel = Forecast(value: forecastDict)
                forecast.append(forecastModel)
            }
        }
    }
    
    static func getWeather(from value: Any) -> Weather {
        guard let value = value as? [String : Any] else { return value as! Weather }
        let weather = Weather (value: value)
        return weather
    }
}

struct Forecast {
    let day: String
    let temperature: String
    let wind: String
    
    init(value: [String: String]) {
        day = value["day"] ?? ""
        temperature = value["temperature"] ?? ""
        wind = value["wind"] ?? ""
    }
}


