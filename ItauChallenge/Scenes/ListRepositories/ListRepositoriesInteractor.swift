//
//  ListInteractor.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ListRepositoriesBusinessLogic: class {
    func loadRepositories(_ request:ListRepositories.LoadPage.Request)
    func didSelectRepository(at index:Int)
}

protocol ListRepositoriesDataStore: class {
    var items: [Repository] { get set }
    var selectedRepository: Repository? { get set }
}

class ListRepositoriesInteractor: ListRepositoriesBusinessLogic, ListRepositoriesDataStore {
    var items: [Repository] = []
    var selectedRepository: Repository?

    var presenter: ListRepositoriesPresentationLogic?
    var worker: ListRepositoriesWorker?

    func loadRepositories(_ request: ListRepositories.LoadPage.Request) {
        worker?.findGithubRepositories(request.currentPage, callback: { (result) in
            switch result {
            case .success(let response):
                self.presenter?.didLoadRepositories(ListRepositories.LoadPage.Response(repositories: response.items))
                self.items.append(contentsOf: response.items)
                
            case .failure(let error):
                self.presenter?.didFailLoadRepositories(error: error)
            }
        })
    }

    func didSelectRepository(at index:Int) {
        selectedRepository = items[index]
        presenter?.presentRepoPullRequests()
    }
}
