//
//  DetailRouter.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol DetailRoutingLogic: class {

}

protocol DetailDataPassing: class {
  var dataStore: DetailDataStore? { get }
}

final class DetailRouter: DetailRoutingLogic, DetailDataPassing {

  weak var viewController: DetailController?
  var dataStore: DetailDataStore?

}
