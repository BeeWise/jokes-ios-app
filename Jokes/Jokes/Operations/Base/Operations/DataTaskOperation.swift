//
//  DataTaskOperation.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

public protocol OperationProtocol: AnyObject {
    associatedtype T: Codable
    var model: Any? { get set }
    var completionHandler: ((Result<OperationResult<T>, OperationError>) -> Void) { get set }
    var request: URLRequest { get }
    var task: URLSessionDataTask? { get set }
}

public struct OperationResult<T: Codable> {
    public let value: T
    public let pageCount: Int?
    public let itemsPerPage: Int?
    
    public init(value: T, pageCount: Int?, itemsPerPage: Int?) {
        self.value = value
        self.pageCount = pageCount
        self.itemsPerPage = itemsPerPage
    }
}

public class DataTaskOperation<T: Codable>: AsynchronousOperation, OperationProtocol {
    public var model: Any?
    public var completionHandler: ((Result<OperationResult<T>, OperationError>) -> Void)
    public var request: URLRequest { return URLRequest(url: URL(string: "https://url.com")!) }
    public var task: URLSessionDataTask?
    
    public init(model: Any? = nil, completionHandler: @escaping ((Result<OperationResult<T>, OperationError>) -> Void)) {
        self.model = model
        self.completionHandler = completionHandler
        super.init()
        self.setupTask()
    }
    
    override public func main() {
        if self.shouldCancelOperation() {
            return
        }
        self.task?.resume()
    }
    
    override public func cancel() {
        self.task?.cancel()
        super.cancel()
    }
    
    func setupTask() {
        self.task = URLSession.shared.dataTask(with: self.request, completionHandler: { (data, response, error) in
            self.log(request: self.request, data: data, response: response, error: error)
            self.verifyResponse(response: response, data: data)
        })
    }
    
    func verifyResponse(response: URLResponse?, data: Data?) {
        if self.shouldCancelOperation() {
            return
        }
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            switch statusCode {
                case OperationStatusCode.ok.rawValue: self.verifyData(data: data); break
                default: self.responseErrorBlock(errorDescription: (String(describing: statusCode)), code: statusCode); break
            }
        } else {
            self.noDataAvailableErrorBlock()
        }
    }
    
    func verifyData(data: Data?) {
        if self.shouldCancelOperation() {
            return
        }
        if let data = data {
            self.decodeData(data: data)
        } else {
            self.noDataAvailableErrorBlock()
        }
    }
    
    func decodeData(data: Data) {
        if self.shouldCancelOperation() {
            return
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.utcFormatter)
            let response = try decoder.decode(APIResponse<T>.self, from: data)
            self.transformResponse(response: response)
        } catch {
            self.cannotParseResponseErrorBlock()
        }
    }
    
    func transformResponse(response: APIResponse<T>) {
        if self.shouldCancelOperation() {
            return
        }
        if let data = response.data {
            self.successfulResultBlock(value: data, pageCount: response.pagination?.pageCount, itemsPerPage: response.pagination?.itemsPerPage)
        } else if let error = response.errors?.first, let description = error.description {
            self.responseErrorBlock(errorDescription: description, code: error.code)
        } else {
            self.noDataAvailableErrorBlock()
        }
    }
    
    func shouldCancelOperation() -> Bool {
        if self.isCancelled {
            self.cancelledOperationErrorBlock()
            return true
        }
        return false
    }
    
    // MARK: - Successful result
    
    func successfulResultBlock(value: T, pageCount: Int?, itemsPerPage: Int?) {
        self.completionHandler(Result.success(OperationResult(value: value, pageCount: pageCount, itemsPerPage: itemsPerPage)))
        self.completeOperation()
    }
    
    // MARK: - Operation errors
    
    func noDataAvailableErrorBlock() {
        self.completionHandler(Result.failure(OperationError.noDataAvailable))
        self.completeOperation()
    }
    
    func cannotParseResponseErrorBlock() {
        self.completionHandler(Result.failure(OperationError.cannotParseResponse))
        self.completeOperation()
    }
    
    func cancelledOperationErrorBlock() {
        self.completionHandler(Result.failure(OperationError.operationCancelled))
        self.completeOperation()
    }
    
    // MARK: - Server errors
        
    func responseErrorBlock(errorDescription: String, code: Int?) {
        self.completionHandler(Result.failure(OperationError.error(message: errorDescription, code: code)))
        self.completeOperation()
    }
}
