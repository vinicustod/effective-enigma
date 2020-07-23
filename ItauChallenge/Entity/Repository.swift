//
//  Repository.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let fullName: String
    let description: String
    let forks: Int
    let stargazersCount: Int
    let owner: User
}
