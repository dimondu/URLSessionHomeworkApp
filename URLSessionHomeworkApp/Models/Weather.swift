//
//  Wether.swift
//  URLSessionHomeworkApp
//
//  Created by Дмитрий Дуров on 08.08.2022.
//


enum WeatherUrl: String {
    case weatherURL = "https://goweather.herokuapp.com/weather/Moscow"
}

struct Weather: Decodable {
    let temperature: String
    let wind: String
    let description: String
    let forecast: [Forecast]
}

struct Forecast: Decodable {
    let day: String
    let temperature: String
    let wind: String
}
