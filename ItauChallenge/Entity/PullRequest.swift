//
//  PullRequest.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct PullRequest:Decodable {
    let title: String
    let user: User
    let body: String
}
