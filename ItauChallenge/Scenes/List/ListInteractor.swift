//
//  ListInteractor.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol ListBusinessLogic: class {

}

protocol ListDataStore: class {

}

class ListInteractor: ListBusinessLogic, ListDataStore {

  var presenter: ListPresentationLogic?
  var worker: ListWorker?

}
