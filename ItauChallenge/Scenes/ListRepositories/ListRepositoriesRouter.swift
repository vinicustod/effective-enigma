//
//  ListRouter.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import UIKit

protocol ListRepositoriesRoutingLogic: class {
    func routeToRepoPullRequests()
}

protocol ListRepositoriesDataPassing: class {
    var dataStore: ListRepositoriesDataStore? { get }
}

final class ListRepositoriesRouter: ListRepositoriesRoutingLogic, ListRepositoriesDataPassing {

    weak var viewController: ListRepositoriesController?
    var dataStore: ListRepositoriesDataStore?

    func routeToRepoPullRequests() {
        let repoPullRequestsViewController = UIStoryboard(name: "RepoPullRequests", bundle: nil).instantiateViewController(withIdentifier: "RepoPullRequestsController") as! RepoPullRequestsController

        var destinationDataStore = repoPullRequestsViewController.router!.dataStore!

        passSelectedRepository(source: dataStore!,
                               destination: &destinationDataStore)

        viewController?.navigationController?.pushViewController(repoPullRequestsViewController, animated: true)
    }

    func passSelectedRepository(source: ListRepositoriesDataStore, destination: inout RepoPullRequestsDataStore) {
      destination.repository = source.selectedRepository
    }
}
