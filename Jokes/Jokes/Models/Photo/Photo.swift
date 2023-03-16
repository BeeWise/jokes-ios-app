//
//  Photo.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 15.03.2023.
//

import Foundation

public class Photo: Codable {
    public var uuid: String?
    public var createdAt: Date
    public var updatedAt: Date
    
    public var user: User?
    
    public var url: String?
    public var url150: String?
    public var url450: String?
    
    public init(uuid: String?, url: String? = nil) {
        self.uuid = uuid
        self.createdAt = Date()
        self.updatedAt = Date()
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user = "user"
        case url = "url"
        case url150 = "url_150"
        case url450 = "url_450"
    }
}
