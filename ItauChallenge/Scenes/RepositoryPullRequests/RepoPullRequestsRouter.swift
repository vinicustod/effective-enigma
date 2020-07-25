//
//  RepoPullRequestsRouter.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol RepoPullRequestsRoutingLogic: class {
    func dismiss()
}

protocol RepoPullRequestsDataPassing: class {
    var dataStore: RepoPullRequestsDataStore? { get }
}

final class RepoPullRequestsRouter: RepoPullRequestsRoutingLogic, RepoPullRequestsDataPassing {

    weak var viewController: RepoPullRequestsController?
    var dataStore: RepoPullRequestsDataStore?

    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }


}
