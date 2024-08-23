//
//  CommentModel.swift
//  Here_come
//
//  Created by 김성률 on 8/22/24.
//

import Foundation

struct CommentResponse: Codable {
    let commentId: String
    let content: String
    let createdAt: String
    let creator: CommentCreator
    
    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case content
        case createdAt
        case creator
    }
}

struct CommentCreator: Codable {
    let userId: String
    let nick: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nick
    }
}
