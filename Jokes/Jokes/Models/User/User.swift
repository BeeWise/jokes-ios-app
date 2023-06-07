//
//  User.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.03.2023.
//

import Foundation

public class User: Codable {
    public static var currentUser: User?
    
    public var uuid: String
    public var createdAt: Date
    public var updatedAt: Date
    
    public var username: String?
    public var email: String?
    public var name: String?
    
    public var photo: Photo?
    
    public var points: String = String()
    
    public init(uuid: String) {
        self.createdAt = Date()
        self.updatedAt = Date()
        self.uuid = uuid
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case username
        case email
        case name
        case photo = "photo"
        case points = "points"
    }
}
