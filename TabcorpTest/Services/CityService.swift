//
//  CityService.swift
//  TabcorpTest
//
//  Created by Alex Gao on 19/11/21.
//

import Foundation

protocol CityServiceProvider {
    func getCities(completion: @escaping (Result<CityAPIResponse, Error>) -> ())
}

class CityService: BaseService, CityServiceProvider {
    func getCities(completion: @escaping (Result<CityAPIResponse, Error>) -> ()) {
        fetch(endpoint: "/weather/list", resultType: CityAPIResponse.self, complitionHandler: completion)
    }
}
