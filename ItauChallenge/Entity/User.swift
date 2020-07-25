//
//  User.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 23/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

struct User: Decodable {
    let login: String
    let avatarUrl: URL
}
