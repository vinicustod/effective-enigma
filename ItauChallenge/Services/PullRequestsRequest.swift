//
//  PullRequestsRequest.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

class PullRequestsRequest: APIRequest {
    var method: RequestType
    var path: String
    var parameters: [String : String]
    
    init(userRepo: String) {
        self.method = .GET
        self.path = "/repo/\(userRepo)/pulls"
        self.parameters = [:]
    }
    
}
