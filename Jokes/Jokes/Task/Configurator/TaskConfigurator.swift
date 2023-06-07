//
//  TaskConfigurator.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

class TaskConfigurator {
    static let shared = TaskConfigurator()
    
    var environment: TaskEnvironment = .memory
    
    init() { }
    
    func jokesTask() -> JokesTaskProtocol {
        return JokesTask(environment: self.environment)
    }
}
