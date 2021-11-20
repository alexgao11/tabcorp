//
//  CityService.swift
//  TabcorpTest
//
//  Created by Alex Gao on 19/11/21.
//

import Foundation

protocol CityServiceProvider {
    func getCities(completion: @escaping (Result<CityAPIResponse, APIRequestError>) -> ())
}

class CityService: BaseService, CityServiceProvider {
    func getCities(completion: @escaping (Result<CityAPIResponse, APIRequestError>) -> ()) {
        fetch(endpoint: "/weather/list", resultType: CityAPIResponse.self, complitionHandler: completion)
    }
}


class MockCityServiceWithSuccessResponse: BaseService, CityServiceProvider {
    func getCities(completion: @escaping (Result<CityAPIResponse, APIRequestError>) -> ()) {
        let result: Result<CityAPIResponse, APIRequestError> = .success(CityAPIResponse(cod: "1", cityList: [CityDetail(id: 1, name: "1")]))
        completion(result)
    }
}

class MockCityServiceWithFaliureResponse: BaseService, CityServiceProvider {
    func getCities(completion: @escaping (Result<CityAPIResponse, APIRequestError>) -> ()) {
        let result: Result<CityAPIResponse, APIRequestError> = .failure(APIRequestError.unableToDecode)
        completion(result)
    }
}
