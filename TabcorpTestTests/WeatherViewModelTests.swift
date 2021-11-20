//
//  WeatherViewModelTests.swift
//  TabcorpTestTests
//
//  Created by Alex Gao on 20/11/21.
//

import XCTest
@testable import TabcorpTest
import RxSwift

class WeatherViewModelTests: XCTestCase {
    
    var bag: DisposeBag!
    
    override func setUp() {
        bag = DisposeBag()
    }

    func testSuccessResponse() {
        let service = MockWeatherServiceWithSuccessResponse()
        let viewModel = WeatherViewModel(service: service)
        let expectation = self.expectation(description: #function)
        let observer = viewModel.weather.subscribe{ event in
            XCTAssertNotNil(event.element)
            expectation.fulfill()
        }
        observer.disposed(by: bag)
        
        viewModel.getWeather()
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFailureResponse() {
        let service = MockWeatherServiceWithFaliureResponse()
        let viewModel = WeatherViewModel(service: service)
        let expectation = self.expectation(description: #function)
        let observer = viewModel.error.subscribe{ event in
            XCTAssertNotNil(event.element)
            XCTAssertTrue(event.element! == APIRequestError.unableToDecode, "Success")
            expectation.fulfill()
        }
        observer.disposed(by: bag)
        
        viewModel.getWeather()
        
        wait(for: [expectation], timeout: 0.5)
    }
}
