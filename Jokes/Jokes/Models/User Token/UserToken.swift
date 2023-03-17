//
//  UserToken.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 16.03.2023.
//

import Foundation

public class UserToken: Codable {
    public static var currentUserToken: UserToken?
    
    public var uuid: String
    public var createdAt: Date
    public var updatedAt: Date
    
    public var expiresAt: Date
    public var token: String
    public var deviceId: String?
    
    public var user: User?
    
    public init(uuid: String) {
        self.uuid = uuid
        self.createdAt = Date()
        self.updatedAt = Date()
        self.expiresAt = Date()
        self.token = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case expiresAt = "expires_at"
        case token
        case deviceId = "device_id"
        case user
    }
}
