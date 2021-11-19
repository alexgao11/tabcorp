//
//  City.swift
//  TabcorpTest
//
//  Created by Alex Gao on 19/11/21.
//

import Foundation

struct CityAPIResponse: Decodable {
    let cod: String
    let cityList: [CityDetail]
    enum CodingKeys: String, CodingKey {
        case cod
        case cityList = "list"
    }
}

struct CityDetail: Decodable {
    let id: Int
    let name: String
}
