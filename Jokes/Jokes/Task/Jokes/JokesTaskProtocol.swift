//
//  JokesTaskProtocol.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

protocol JokesTaskProtocol {
    func fetchJokes(model: JokesTaskModels.FetchJokes, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void)
    func cancelFetchJokesOperations()
}
