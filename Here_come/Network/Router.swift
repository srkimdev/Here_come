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
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
            return .post
        case .refresh:
            return .get
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
        }
    }
    
}
