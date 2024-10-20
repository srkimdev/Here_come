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
    case accessToken
    case uploadImage
    case uploadPost(query: PostQuery)
    case readPost(productId: String)
    case readOnePost(postId: String)
    case readImage
    case readHashTag(hashTag: String)
    case deletePost(postId: String)
    case likePost(postId: String, query: LikeQuery)
    case makeComment(postId: String, query: CommentQuery)
    case payments(query: PaymentQuery)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
            return .post
        case .accessToken:
            return .get
        case .uploadImage:
            return .post
        case .uploadPost:
            return .post
        case .readPost:
            return .get
        case .readOnePost:
            return .get
        case .readImage:
            return .get
        case .readHashTag:
            return .get
        case .deletePost:
            return .delete
        case .likePost:
            return .post
        case .makeComment:
            return .post
        case .payments:
            return .post
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .readPost(let productId):
            return [URLQueryItem(name: "product_id", value: productId)]
        
        case .readHashTag(let hashTag):
            return [URLQueryItem(name: "hashTag", value: hashTag)]
        
        default:
            return nil
        }
    
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
        case .uploadPost(let query):
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
            
        case .likePost(_, let query):
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
            
        case .makeComment(_, let query):
            let encoder = JSONEncoder()
            
            do {
                let data = try encoder.encode(query)
                return data
            } catch {
                return nil
            }
            
        case .payments(let query):
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
        case .accessToken:
            return "/auth/refresh"
        case .uploadImage:
            return "/posts/files"
        case .uploadPost:
            return "/posts"
        case .readPost:
            return "/posts"
        case .readOnePost(let postId):
            return "/posts/\(postId)"
        case .readHashTag:
            return "/posts/hashtags"
        case .deletePost(let postId):
            return "/posts/\(postId)"
        case .likePost(let postId, _):
            return "/posts/\(postId)/like"
        case .makeComment(let postId, _):
            return "/posts/\(postId)/comments"
        case .payments:
            return "/payments/validation"
        default:
            return ""
        }
    }
    
    var header: [String: String] {
        switch self {
        case .login:
            return [
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        case .accessToken:
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
        case .uploadPost, .likePost, .makeComment, .payments:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.contentType.rawValue: Header.json.rawValue,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        case .readPost, .readOnePost, .readImage, .readHashTag, .deletePost:
            return [
                Header.authorization.rawValue: UserDefaultsManager.shared.token,
                Header.sesacKey.rawValue: APIKey.Key
            ]
        }
    }
    
}
