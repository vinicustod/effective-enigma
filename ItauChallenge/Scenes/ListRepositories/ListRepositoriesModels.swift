//
//  ListModels.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

enum ListRepositories {

  enum LoadPage {

    struct Request {
        let currentPage:Int
    }

    struct Response {
        let repositories: [Repository]
    }

    struct ViewModel {
        let repositories: [Repository]
    }
  }
}
