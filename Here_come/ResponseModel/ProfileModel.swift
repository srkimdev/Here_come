//
//  ProfileModel.swift
//  Here_come
//
//  Created by 김성률 on 8/23/24.
//

import Foundation

struct ProfileModel: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let phoneNum: String
    let followers: [Creator]
    let following: [Creator]
    let posts: [String]
}
