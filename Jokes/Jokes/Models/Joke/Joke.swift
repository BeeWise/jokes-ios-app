//
//  Joke.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.03.2023.
//

import Foundation

public class Joke: Codable {
    public var uuid: String
    public var createdAt: Date
    public var updatedAt: Date
    
    public var text: String?
    public var answer: String?
    public var source: String?
    
    public var user: User?
    
    public var likeCount: Int = 0
    public var dislikeCount: Int = 0
    public var commentCount: Int = 0
    
    public var points: String = String()
    
    public var type: Int?
    public var status: Int?
    
    public init(uuid: String) {
        self.createdAt = Date()
        self.updatedAt = Date()
        self.uuid = uuid
    }
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case text
        case answer
        case source
        case user
        case likeCount = "like_count"
        case dislikeCount = "dislike_count"
        case commentCount = "comment_count"
        case points = "points"
        case type
        case status
    }
}
