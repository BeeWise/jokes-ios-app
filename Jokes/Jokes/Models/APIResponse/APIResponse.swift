//
//  APIResponse.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 17.03.2023.
//

import Foundation

public struct APIResponse<T>: Codable where T: Codable {
    public var errors: [APIError]?
    public var data: T?
    public var pagination: APIPagination?
    
    public init(data: T?, pagination: APIPagination?, errors: [APIError]?) {
        self.data = data
        self.pagination = pagination
        self.errors = errors
    }
}

public final class APIError: Codable {
    public var description: String?
    public var code: Int?
    
    public init(description: String?, code: Int) {
        self.description = description
        self.code = code
    }
}

public final class APIPagination: Codable {
    public var pageCount: Int?
    public var itemsPerPage: Int?
    
    public init(pageCount: Int?, itemsPerPage: Int?) {
        self.pageCount = pageCount
        self.itemsPerPage = itemsPerPage
    }
    
    enum CodingKeys: String, CodingKey {
        case pageCount = "page_count"
        case itemsPerPage = "items_per_page"
    }
}
