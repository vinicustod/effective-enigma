//
//  MockGithubService.swift
//  ItauChallengeTests
//
//  Created by Vinicius Custodio on 24/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

@testable import ItauChallenge
import XCTest

enum MockGithubServiceType {
    case searchRepos
    case repoPullRequests
    case error

    var filename: String {
        switch self {
        case .repoPullRequests:
            return "RepoPRs"

        case .searchRepos:
            return "SearchRepo"

        default:
            return ""
        }
    }
}

class MockGithubService: ServiceInterface {

    var mockType: MockGithubServiceType?

    func send<T>(apiRequest: APIRequest, callback: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask where T : Decodable {
        switch mockType! {
        case .searchRepos, .repoPullRequests:
            if let model:T = loadFile(mockType!.filename) {
                callback(.success(model))
            }

        case .error:
            callback(.failure(GithubAPIError.decodingError))

        }

        return URLSessionDataTask()
    }

    func loadFile<T: Decodable>(_ filename: String) -> T? {
        do {
            let bundle = Bundle(for: type(of: self))
            let path = bundle.url(forResource: filename, withExtension: "json")
            let jsonData = try Data(contentsOf: path!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let model:T = try decoder.decode(T.self, from: jsonData)
            return model
        } catch {
            return nil
        }

    }


}
