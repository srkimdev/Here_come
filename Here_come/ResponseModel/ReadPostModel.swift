//
//  ReadPostModel.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import Foundation

struct ReadPostModel: Decodable {
    let data: [Posts]
    let next_cursor: String
}

struct Posts: Decodable {
    let post_id: String
    let product_id: String
    let title: String
    let content: String
    let content1: String
    let createdAt: String
//    let creator: User
    let files: [String]?
    let likes: [String]
    let comments: [Comment]?
}

struct User: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
}

struct Comment: Codable {
    let commentId: String          // 댓글 ID
    let content: String            // 댓글 내용
    let createdAt: String          // 댓글 작성 날짜
    let creator: Creator           // 댓글 작성자 정보
    
    enum CodingKeys: String, CodingKey {
        case commentId = "comment_id"
        case content
        case createdAt
        case creator
    }
}

struct Creator: Codable {
    let userId: String             // 작성자 ID
    let nick: String               // 작성자 닉네임
    let profileImage: String?      // 프로필 이미지 (선택적)
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nick
        case profileImage
    }
}
