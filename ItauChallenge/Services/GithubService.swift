//
//  Service.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ServiceInterface: AnyObject {
    func send<T:Decodable>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void)
}

class GithubService: ServiceInterface {
    private let baseURL = URL(string: "")!

    func send<T:Decodable>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void) {
        let request = apiRequest.request(with: self.baseURL)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                callback(.success(model))
                
            } catch let error {
                callback(.failure(error))
            }
        }

        task.resume()
    }
}
