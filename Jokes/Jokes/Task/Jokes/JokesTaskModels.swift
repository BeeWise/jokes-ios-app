//
//  JokesTaskModels.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

enum JokesTaskModels {
    struct FetchJokes {
        var page: Int?
        var limit: Int?
        
        init() {
            
        }
    }
}
