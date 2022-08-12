//
//  NetworkManager.swift
//  URLSessionHomeworkApp
//
//  Created by Дмитрий Дуров on 11.08.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    var weatherURL: String {
        "https://goweather.herokuapp.com/weather/\(city)"
    }
    
    private let city = "Moscow"
    
    static let shared = NetworkManager()

    private init() {}

    func fetchWeather(from url: String?, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: weatherURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(weather))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
