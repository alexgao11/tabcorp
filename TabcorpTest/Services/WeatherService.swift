//
//  WeatherService.swift
//  TabcorpTest
//
//  Created by Alex Gao on 20/11/21.
//

import Foundation

protocol WeatherServiceProvider {
    func getWeather(completion: @escaping (Result<Weather, APIRequestError>) -> ())
}

class WeatherService: BaseService, WeatherServiceProvider {
    private let cityId: String
    
    init(cityId: String) {
        self.cityId = cityId
    }
    
    func getWeather(completion: @escaping (Result<Weather, APIRequestError>) -> ()) {
        fetch(endpoint: "/\(Constants.weatherEndpoint)/\(cityId)", resultType: Weather.self, complitionHandler: completion)
    }
}


class MockWeatherServiceWithSuccessResponse: WeatherServiceProvider {
    func getWeather(completion: @escaping (Result<Weather, APIRequestError>) -> ()) {
        let result: Result<Weather, APIRequestError> = .success(Weather(id: 0, dt: 0, cityName: "", main: nil, wind: nil, rain: nil, clouds: nil, weather: nil, sys: nil))
        completion(result)
    }
}

class MockWeatherServiceWithFaliureResponse: WeatherServiceProvider {
    func getWeather(completion: @escaping (Result<Weather, APIRequestError>) -> ()) {
        let result: Result<Weather, APIRequestError> = .failure(APIRequestError.unableToDecode)
        completion(result)
    }
}
