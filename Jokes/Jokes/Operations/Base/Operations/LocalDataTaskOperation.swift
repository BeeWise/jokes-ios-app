//
//  LocalDataTaskOperation.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

public class LocalDataTaskOperation<T: Codable>: DataTaskOperation<T> {
    override func setupTask() {
        self.task = nil
    }
}
