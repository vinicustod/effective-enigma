//
//  RepoPullRequestsPresenter.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol RepoPullRequestsPresentationLogic: class {
    func didFindPullRequests(_ response: RepoPullRequests.LoadPullRequests.Response)
    func didFailFindPullRequests(_ error: Error)
}

final class RepoPullRequestsPresenter: RepoPullRequestsPresentationLogic {

    weak var viewController: RepoPullRequestsDisplayLogic?

    func didFindPullRequests(_ response: RepoPullRequests.LoadPullRequests.Response) {
        viewController?.showPullRequests(RepoPullRequests.LoadPullRequests.ViewModel(pullRequests: response.pullRequests))
    }

    func didFailFindPullRequests(_ error: Error) {
        viewController?.showError(error)
    }

}
