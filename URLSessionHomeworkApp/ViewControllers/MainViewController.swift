//
//  ViewController.swift
//  URLSessionHomeworkApp
//
//  Created by Дмитрий Дуров on 08.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var temperatureTodayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var forecastFirstDayLabel: UILabel!
    
    @IBOutlet weak var forecastSecondDayLabel: UILabel!
    @IBOutlet weak var forecastThirdDayLabel: UILabel!
    
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }
}

extension MainViewController {
    
    private func fetchWeather() {
        NetworkManager.shared.fetchWeather(from: WeatherUrl.weatherURL.rawValue) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.temperatureTodayLabel.text = "\(weather.temperature)"
                self?.descriptionLabel.text = "\(weather.description)"
                self?.windLabel.text = "Скорость ветра: \(weather.wind)"
                
                for weather in weather.forecast {
                    if weather.day == "1"{
                        self?.forecastFirstDayLabel.text = """
                            Через \(weather.day) день
                            Температура: \(weather.temperature)
                            Скорость ветра: \(weather.wind)
                            """
                    }else if weather.day == "2" {
                        self?.forecastSecondDayLabel.text = """
                            Через \(weather.day) дня
                            Температура: \(weather.temperature)
                            Скорость ветра: \(weather.wind)
                            """
                    }else {
                        self?.forecastThirdDayLabel.text = """
                            Через \(weather.day) дня
                            Температура: \(weather.temperature)
                            Скорость ветра: \(weather.wind)
                            """
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

