//
//  ViewController.swift
//  URLSessionHomeworkApp
//
//  Created by Дмитрий Дуров on 08.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let city = "Moscow"
    
    private var weatherURL: String {
        "https://goweather.herokuapp.com/weather/\(city)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }
}

extension MainViewController {
    private func fetchWeather() {
        guard let url = URL(string: weatherURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                print(weather)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

