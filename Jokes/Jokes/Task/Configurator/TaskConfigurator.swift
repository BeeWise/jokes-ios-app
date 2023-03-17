//
//  TaskConfigurator.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

public class TaskConfigurator {
    public static let shared = TaskConfigurator()
    
    public var environment: TaskEnvironment = .memory
    
    init() { }
}
