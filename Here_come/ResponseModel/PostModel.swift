//
//  PostModel.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import Foundation

struct PostModel: Decodable {
    let title: String
    let content: String
    let product_id: String
    let files: [String]
}
