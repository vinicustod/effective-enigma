//
//  RepoPullRequestsInteractor.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol RepoPullRequestsBusinessLogic: class {
    func loadPullRequests(_ request: RepoPullRequests.LoadPullRequests.Request)
}

protocol RepoPullRequestsDataStore: class {
    var repository:Repository? { get set }
}

class RepoPullRequestsInteractor: RepoPullRequestsBusinessLogic, RepoPullRequestsDataStore {
    var repository: Repository?

    var presenter: RepoPullRequestsPresentationLogic?
    var worker: RepoPullRequestsWorker?

    func loadPullRequests(_ request: RepoPullRequests.LoadPullRequests.Request) {
        worker?.findPullRequests(repository!.fullName, callback: { (result) in
            switch result {
            case .success(let pullRequests):
                self.presenter?.didFindPullRequests(RepoPullRequests.LoadPullRequests.Response(pullRequests: pullRequests))

            case .failure(let error):
                self.presenter?.didFailFindPullRequests(error)
            }
        })
    }

}
