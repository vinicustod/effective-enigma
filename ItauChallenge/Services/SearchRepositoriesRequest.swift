//
//  SearchRepositoriesRequest.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 22/07/20.
//  Copyright © 2020 Vinicius Custodio. All rights reserved.
//

import Foundation

class SearchRepositoriesRequest: APIRequest {
    var method: RequestType
    var path: String
    var parameters: [String : String]
    
    init(page:Int, query: String = "language:Java", sort: String = "stars") {
        self.method = .GET
        self.path = "/search/repositories"
        self.parameters = ["q": query,
                           "sort": sort,
                           "page": String(page)]
        
    }
}
