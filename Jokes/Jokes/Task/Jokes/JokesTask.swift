//
//  JokesTask.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

enum JokesTaskModels {
    struct FetchJokes {
        var page: Int?
        var limit: Int?
    }
}

protocol JokesTaskProtocol: TaskProtocol {
    func fetchJokes(model: JokesTaskModels.FetchJokes, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void)
    func cancelFetchJokesOperations()
}

class JokesTask: JokesTaskProtocol {
    var fetchJokesOperationQueue = OperationQueue()
    
    var environment: TaskEnvironment
    
    init(environment: TaskEnvironment) {
        self.environment = environment
    }
    
    // MARK: - Fetch jokes
    
    func fetchJokes(model: JokesTaskModels.FetchJokes, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void) {
        let operation = self.fetchJokesOperation(model: model, completionHandler: completionHandler)
        self.fetchJokesOperationQueue.addOperation(operation)
    }
    
    func fetchJokesOperation(model: JokesTaskModels.FetchJokes, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void) -> DataTaskOperation<[Joke]> {
        let operationModel = GetJokesOperationModel.Request(page: model.page, limit: model.limit)
        switch self.environment {
            case .production: return self.productionGetJokesOperation(model: operationModel, completionHandler: completionHandler)
            case .development: return self.developmentGetJokesOperation(model: operationModel, completionHandler: completionHandler)
            case .memory: return self.memoryGetJokesOperation(model: operationModel, completionHandler: completionHandler)
        }
    }
    
    func cancelFetchJokesOperations() {
        self.fetchJokesOperationQueue.cancelAllOperations()
    }
}

// MARK: - Fetch jokes operations

extension JokesTask {
    private func productionGetJokesOperation(model: GetJokesOperationModel.Request, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void) -> GetJokesOperation {
        return GetJokesOperation(model: model) { result in
            switch result {
                case .success(let value): completionHandler(Result.success(value.value)); break
                case .failure(let error): completionHandler(Result.failure(error)); break
            }
        }
    }
    
    private func developmentGetJokesOperation(model: GetJokesOperationModel.Request, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void) -> GetJokesOperation {
        return GetJokesOperation(model: model) { result in
            switch result {
                case .success(let value): completionHandler(Result.success(value.value)); break
                case .failure(let error): completionHandler(Result.failure(error)); break
            }
        }
    }
    
    private func memoryGetJokesOperation(model: GetJokesOperationModel.Request, completionHandler: @escaping (Result<[Joke], OperationError>) -> Void) -> GetJokesLocalOperation {
        return GetJokesLocalOperation(model: model) { result in
            switch result {
                case .success(let value): completionHandler(Result.success(value.value)); break
                case .failure(let error): completionHandler(Result.failure(error)); break
            }
        }
    }
}
