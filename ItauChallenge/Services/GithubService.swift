//
//  Service.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

enum GithubAPIError: Error {
    case decodingError

    var localizedDescription: String {
        switch self {
        case .decodingError:
            return "Erro ao acessar a API do Github."
        }
    }
}

protocol ServiceInterface: AnyObject {
    func send<T:Decodable>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask
}

class GithubService: ServiceInterface {
    private let baseURL = URL(string: "https://api.github.com")!

    func send<T:Decodable>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        let request = apiRequest.request(with: self.baseURL)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print(jsonResult)
                }
                let model: T = try decoder.decode(T.self, from: data ?? Data())
                DispatchQueue.main.async {
                    callback(.success(model))
                }

            } catch {
                DispatchQueue.main.async {
                    callback(.failure(GithubAPIError.decodingError))
                }
            }
        }

        task.resume()

        return task
    }
}
