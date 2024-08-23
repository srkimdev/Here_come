//
//  PostQuery.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import Foundation

struct PostQuery: Encodable {
    let title: String
    let content: String
    let content1: String
    let product_id: String
    let files: [String]
}
