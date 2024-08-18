//
//  Router.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation
import Alamofire

enum Router: TargetType {

    case login(query: LoginQuery)
    case refresh
    case uploadImage
    case uploadPost
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
            return .post
        case .refresh:
            return .get
        case .uploadImage:
            return .post
        case .uploadPost:
            return .post
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
            
        default:
            return nil
            
        }
    }

    var baseURL: String {
        return APIKey.baseURL + "v1"
    }
    
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .refresh:
            return "/auth/refresh"
        case .uploadImage:
            return "/posts/files"
        case .uploadPost:
            return "/posts"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        case .refresh:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.refresh.rawValue: UserDefaultsManager.shared.refreshToken,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        case.uploadImage:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.multipart.rawValue,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        case .uploadPost:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        }
    }
    
}
