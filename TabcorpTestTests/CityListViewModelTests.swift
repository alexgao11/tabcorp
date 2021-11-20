//
//  CityListViewModelTests.swift
//  TabcorpTestTests
//
//  Created by Alex Gao on 20/11/21.
//

import XCTest
@testable import TabcorpTest
import RxSwift

class CityListViewModelTests: XCTestCase {

    func testSuccessResponse() {
        let service = MockCityServiceWithSuccessResponse()
        let viewModel = CitiesViewModel(service: service)
        let bag = DisposeBag()
        let expectation = self.expectation(description: #function)
        let observer = viewModel.cities.subscribe{ event in
            XCTAssertNotNil(event.element)
            expectation.fulfill()
        }
        observer.disposed(by: bag)
        
        viewModel.getCities()
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFailureResponse() {
        let service = MockCityServiceWithFaliureResponse()
        let viewModel = CitiesViewModel(service: service)
        let bag = DisposeBag()
        let expectation = self.expectation(description: #function)
        let observer = viewModel.error.subscribe{ event in
            XCTAssertNotNil(event.element)
            XCTAssertTrue(event.element! == APIRequestError.unableToDecode, "Success")
            expectation.fulfill()
        }
        observer.disposed(by: bag)
        
        viewModel.getCities()
        
        wait(for: [expectation], timeout: 0.5)
    }
}
