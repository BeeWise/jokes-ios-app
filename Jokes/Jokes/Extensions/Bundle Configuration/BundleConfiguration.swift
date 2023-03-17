//
//  BundleConfiguration.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.03.2023.
//

import Foundation

public enum BundleConfiguration {
    public enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    public static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }
        switch object {
            case let value as T:
                return value
            case let string as String:
                guard let value = T(string) else { fallthrough }
                return value
            default:
                throw Error.invalidValue
        }
    }
    
    public static func string(for key: String, defaultValue: String = "") -> String {
        do {
            return try BundleConfiguration.value(for: key)
        } catch {
            return defaultValue
        }
    }
    
    public static func bool(for key: String, defaultValue: Bool = false) -> Bool {
        do {
            return try BundleConfiguration.value(for: key)
        } catch {
            return defaultValue
        }
    }
    
    struct Keys {
        static let
            taskConfiguratorEnvironment = "TASK_CONFIGURATOR_ENVIRONMENT",
        operationLoggingEnabled = "OPERATION_LOGGING_ENABLED",
        jokesEndpoint = "JOKES_ENDPOINT"
    }
}
