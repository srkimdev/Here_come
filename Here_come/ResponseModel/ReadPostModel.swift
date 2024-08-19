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
    let title: String?
    let content: String
    let createdAt: String
//    let creator: User
    let files: [String]?
//    let likes: [String]
//    let comments: [String]
}

struct User: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String
}
