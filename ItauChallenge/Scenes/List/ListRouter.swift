//
//  ListRouter.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ListRoutingLogic: class {

}

protocol ListDataPassing: class {
  var dataStore: ListDataStore? { get }
}

final class ListRouter: ListRoutingLogic, ListDataPassing {

  weak var viewController: ListController?
  var dataStore: ListDataStore?

}
