//
//  TaskEnvironment.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

public enum TaskEnvironment: String {
    case production
    case development
    case memory
    
    public static func from(value: String) -> TaskEnvironment {
        return TaskEnvironment(rawValue: value) ?? .memory
    }
}
