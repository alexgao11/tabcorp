//
//  CityListViewModel.swift
//  TabcorpTest
//
//  Created by Alex Gao on 19/11/21.
//

import Foundation
import RxSwift

class CitiesViewModel {
    let service: CityServiceProvider
    var cities: PublishSubject<[CityDetail]> = PublishSubject()
    let errorMessage: PublishSubject<String> = PublishSubject()
    
    init(service: CityServiceProvider) {
        self.service = service
    }
    
    func getCities()  {
        service.getCities { result in
            switch result {
            case .success(let response):
                self.cities.onNext(response.cityList)
            case .failure(let error):
                self.errorMessage.onNext(error.localizedDescription)
            }
        }
        
    }
}
