//
//  RepoPullRequestsModels.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

enum RepoPullRequests {

  enum LoadPullRequests {

    struct Request {
        
    }

    struct Response {
        let pullRequests: [PullRequest]
    }

    struct ViewModel {
        let pullRequests: [PullRequest]
    }
  }
}
