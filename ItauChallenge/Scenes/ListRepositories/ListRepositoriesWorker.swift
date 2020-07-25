//
//  ListWorker.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

final class ListRepositoriesWorker {
    let githubAPI: ServiceInterface
    var dataTask: URLSessionDataTask?

    init(githubAPI: ServiceInterface) {
        self.githubAPI = githubAPI
    }

    func findGithubRepositories(_ page: Int, callback:@escaping (Result<SearchRepositoriesResponse, Error>) -> Void) {
        guard dataTask?.state != .running else {
            return
        }

        let searchRepositoryRequest = SearchRepositoriesRequest(page: page)

        dataTask = githubAPI.send(apiRequest: searchRepositoryRequest, callback: callback)
    }
}
