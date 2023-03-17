//
//  OperationRequestBuilder.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

protocol RequestBuilderProtocol: AnyObject {
    associatedtype T
    var model: T { get set }
    var url: String { get }
    var request: URLRequest { get }
    var httpMethod: HTTPMethod { get }
    var queryParameters: [String: Any] { get }
    var bodyParameters: Codable? { get }
    var requiresAuthorization: Bool { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

class OperationRequestBuilder<T>: RequestBuilderProtocol {
    var model: T
    
    var url: String {
        return ""
    }
    
    var request: URLRequest {
        var urlComponents = URLComponents(string: self.url)!
        if self.queryParameters.count > 0 {
            urlComponents.queryItems = self.queryParameters.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
        }
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if self.requiresAuthorization {
            request.setValue("Bearer \(UserToken.currentUserToken?.token ?? "")", forHTTPHeaderField: "Authorization")
        }
        if let body = self.bodyParameters {
            request.httpBody = body.jsonData()
        }
        return request
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var queryParameters: [String : Any] {
        return [:]
    }
    
    var bodyParameters: Codable? {
        return nil
    }
    
    var requiresAuthorization: Bool {
        return false
    }
    
    init(model: T) {
        self.model = model
    }
}

extension Encodable {
    func jsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
