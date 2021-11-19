//
//  BaseService.swift
//  TabcorpTest
//
//  Created by Alex Gao on 19/11/21.
//

import Foundation

enum APIRequestError: Error {
    case invalidURL
    case invalidData
    case unableToDecode
}

class BaseService {
    func fetch<T>(endpoint: String, resultType: T.Type, complitionHandler: @escaping (Result<T, Error>) -> ()) where T: Decodable {
        guard let url = URL(string: Constants.baseURL + endpoint) else {
            complitionHandler(.failure(APIRequestError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else {
                complitionHandler(.failure(APIRequestError.invalidData))
                return
            }
            guard let result = try? JSONDecoder().decode(T.self, from: data) else{
                complitionHandler(.failure(APIRequestError.unableToDecode))
                return
            }
            complitionHandler(.success(result))
        }.resume()
    }
}
