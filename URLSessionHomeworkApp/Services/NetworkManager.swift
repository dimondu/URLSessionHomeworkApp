//
//  NetworkManager.swift
//  URLSessionHomeworkApp
//
//  Created by Дмитрий Дуров on 11.08.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}

    func fetchWeather(from url: String, completion: @escaping(Result<Weather, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let weather = Weather.getWeather(from: value)
                    print(weather)
                    completion(.success(weather))
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
                }
            }
    }
}
