//
//  GetJokesOperationModel.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

enum GetJokesOperationModel {
    struct Request {
        var page: Int?
        var limit: Int?
    }
}
