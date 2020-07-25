//
//  ListPresenter.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ListRepositoriesPresentationLogic: class {
    func didLoadRepositories(_ response: ListRepositories.LoadPage.Response)
    func didFailLoadRepositories(error: Error)

    func presentRepoPullRequests()
}

final class ListRepositoriesPresenter: ListRepositoriesPresentationLogic {

    weak var viewController: ListRepositoriesDisplayLogic?

    func didLoadRepositories(_ response: ListRepositories.LoadPage.Response) {
        viewController?.showRepositories(ListRepositories.LoadPage.ViewModel(repositories: response.repositories))
    }

    func didFailLoadRepositories(error: Error) {
        viewController?.showError(error)
    }

    func presentRepoPullRequests() {
        viewController?.showRepoPullRequests()
    }

}
