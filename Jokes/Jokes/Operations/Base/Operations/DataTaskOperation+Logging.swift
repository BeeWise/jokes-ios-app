//
//  DataTaskOperation+Logging.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

extension AsynchronousOperation {
    func log(request: URLRequest?, data: Data?, response: URLResponse?, error: Error?) {
        if BundleConfiguration.bool(for: "OPERATION_LOGGING_ENABLED") {
            print("******************** \(String(describing: type(of: self))) ********************")
            request?.log()
            data?.log()
            response?.log()
            error?.log()
            print("******************** \(String(describing: type(of: self))) ********************")
        }
    }
}

private extension Data {
    func log() {
        print("Data: \(String(decoding: self, as: UTF8.self))")
    }
}

private extension URLRequest {
    func log() {
        print("Request url absolute string: \(self.url?.absoluteString ?? "none")")
        print("Request http method: \(self.httpMethod ?? "none")")
        if let body = self.httpBody {
            print("Request http body: \(String(decoding: body, as: UTF8.self))")
        } else {
            print("Request http body: none")
        }
        print("Request http header fields: \(self.allHTTPHeaderFields ?? [:])")
    }
}

private extension URLResponse {
    func log() {
        if let response = self as? HTTPURLResponse {
            print("Response status code: \(response.statusCode)")
            print("Response header fields: \(response.allHeaderFields)")
            print("Response mime type: \(response.mimeType ?? "none")")
            print("Response expected content length: \(response.expectedContentLength)")
        }
    }
}

private extension Error {
    func log() {
        print("Error: \(self.localizedDescription)")
    }
}

