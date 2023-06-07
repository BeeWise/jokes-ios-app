//
//  JokesInteractor.swift
//  Jokes
//
//  Created by Dimitri Strauneanu on 17.01.2023.
//

import Foundation

protocol JokesBusinessLogic {
    func shouldFetchItems()
}

class JokesInteractor: JokesBusinessLogic, JokesWorkerDelegate {
    var presenter: JokesPresentationLogic?
    var worker: JokesWorker?
    
    var items: [Joke] = []
    var isFetchingItems: Bool = false
    
    init() {
        let environment = TaskEnvironment.from(value: BundleConfiguration.string(for: BundleConfiguration.Keys.taskConfiguratorEnvironment))
        TaskConfigurator.shared.environment = environment
        
        self.worker = JokesWorker(delegate: self)
    }
    
    func shouldFetchItems() {
        if !self.isFetchingItems {
            self.isFetchingItems = true
            self.presenter?.presentLoadingState()
            self.worker?.fetchJokes()
        }
    }
    
    func successDidFetchJokes(jokes: [Joke]) {
        print("successDidFetchJokes \(jokes.count)")
        self.items = jokes
        self.isFetchingItems = false
        
        self.presenter?.presentNotLoadingState()
        self.presenter?.presentItems(response: JokesModels.ItemsPresentation.Response(items: self.items))
    }
    
    func failureDidFetchJokes(error: OperationError) {
        print("failureDidFetchJokes")
        self.isFetchingItems = false
        
        self.presenter?.presentNotLoadingState()
        // TODO: - Present error alert!
    }
}
