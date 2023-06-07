//
//  JokesWorker.swift
//  Jokes
//
//  Created by Dimitri Strauneanu on 17.01.2023.
//

import Foundation

protocol JokesWorkerDelegate: AnyObject {
    func successDidFetchJokes(jokes: [Joke])
    func failureDidFetchJokes(error: OperationError)
}

class JokesWorker {
    weak var delegate: JokesWorkerDelegate?
    
    var jokesTask: JokesTaskProtocol = TaskConfigurator.shared.jokesTask()
    
    init(delegate: JokesWorkerDelegate? = nil) {
        self.delegate = delegate
    }
    
    func fetchJokes() {
        self.jokesTask.environment = TaskConfigurator.shared.environment
        print("TaskConfigurator env \(TaskConfigurator.shared.environment)")
        
        self.jokesTask.fetchJokes(model: JokesTaskModels.FetchJokes(page: 0, limit: 10)) { result in
            switch result {
            case .success(let jokes): self.delegate?.successDidFetchJokes(jokes: jokes); break
            case .failure(let error): self.delegate?.failureDidFetchJokes(error: error); break
            }
        }
    }
}
