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
    case requestError

    var localizedDescription: String {
        switch self {
        case .decodingError:
            return "Erro serializar objeto da API."
        case .requestError:
            return "Erro ao acessar a API."
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
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let model: T = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        callback(.success(model))
                    }

                } catch {
                    DispatchQueue.main.async {
                        callback(.failure(GithubAPIError.decodingError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    callback(.failure(GithubAPIError.requestError))
                }
            }

        }

        task.resume()

        return task
    }
}
