//
//  RepoPullRequestsWorker.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

final class RepoPullRequestsWorker {
    let githubAPI: ServiceInterface

    init(githubAPI: ServiceInterface) {
        self.githubAPI = githubAPI
    }

    func findPullRequests(_ userRepo: String, callback: @escaping (Result<[PullRequest], Error>) -> Void) {
        let findPullRequests = PullRequestsRequest(userRepo: userRepo)

        _ = githubAPI.send(apiRequest: findPullRequests, callback: callback)
    }
}
