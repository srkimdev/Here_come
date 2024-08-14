//
//  LoginModel.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation

struct LoginModel: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let profile: String?
    let accessToken: String
    let refreshToken: String
}
