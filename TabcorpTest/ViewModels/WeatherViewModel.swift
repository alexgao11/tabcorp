//
//  WeatherViewModel.swift
//  TabcorpTest
//
//  Created by Alex Gao on 20/11/21.
//

import Foundation
import RxSwift

class WeatherViewModel {
    let service: WeatherServiceProvider
    var weather: PublishSubject<Weather> = PublishSubject()
    let error: PublishSubject<APIRequestError> = PublishSubject()
    
    init(service: WeatherServiceProvider) {
        self.service = service
    }
    
    func getWeather() {
        service.getWeather() { result in
            switch result {
            case .success(let weather):
                self.weather.onNext(weather)
            case .failure(let error):
                self.error.onNext(error)
            }
        }
    }
}
