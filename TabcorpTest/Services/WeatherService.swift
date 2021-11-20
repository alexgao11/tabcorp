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
