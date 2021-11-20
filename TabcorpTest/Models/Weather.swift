//
//  Weather.swift
//  TabcorpTest
//
//  Created by Alex Gao on 20/11/21.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let dt: Int // data receiving time
    let cityName: String
    let main: Main?
    let wind: Wind?
    let rain: Rain?
    let clouds: Clouds?
    let weather: [CurrentWeather]?
    let sys: Sys?
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case id, dt, main, wind, rain, clouds, weather, sys
    }
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let seaLevel: Double?
    let grndLevel: Double?
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case temp, pressure, humidity
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
}
struct Rain: Decodable {
    let lastThreeHours: Double
    
    enum CodingKeys: String, CodingKey {
        case lastThreeHours = "3h"
    }
}
struct Clouds: Decodable {
    let all: Double
}
struct CurrentWeather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
struct Sys: Decodable {
    let type: Int
    let id: Int
    // let message: Double // Should not use this value from the api spec
    let country: String
    let sunrise: Double
    let sunset: Double
}
