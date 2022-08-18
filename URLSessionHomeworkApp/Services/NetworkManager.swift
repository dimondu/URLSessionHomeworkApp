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
    
    //    func fetchWeather(from url: String?, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
    //        guard let stringURL = url, let url = URL(string: stringURL) else {
    //            completion(.failure(.invalidURL))
    //            return
    //        }
    //
    //        URLSession.shared.dataTask(with: url) { data, _, error in
    //            guard let data = data else {
    //                completion(.failure(.noData))
    //                print(error?.localizedDescription ?? "No error description")
    //                return
    //            }
    //
    //            do {
    //                let weather = try JSONDecoder().decode(Weather.self, from: data)
    //                DispatchQueue.main.async {
    //                    completion(.success(weather))
    //                }
    //            } catch {
    //                completion(.failure(.decodingError))
    //            }
    //        }.resume()
    //    }
    
    
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
