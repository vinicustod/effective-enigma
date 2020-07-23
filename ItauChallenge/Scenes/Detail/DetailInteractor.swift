//
//  DetailInteractor.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

protocol DetailBusinessLogic: class {

}

protocol DetailDataStore: class {

}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {

  var presenter: DetailPresentationLogic?
  var worker: DetailWorker?

}
