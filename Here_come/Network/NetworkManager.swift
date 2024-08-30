//
//  NetworkManager.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation
import Alamofire
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(router: Router, responseType: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        do {
            let request = try router.asURLRequest()
            
            AF.request(request)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    print("callRequest ->", error)
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func accessLogin(id: String, password: String, completionHandler: @escaping (LoginModel) -> Void)  {
        
        do {
            let query = LoginQuery(email: id, password: password)
            let request = try Router.login(query: query).asURLRequest()
            
            AF.request(request).responseDecodable(of: LoginModel.self) { response in
                switch response.result {
                case .success(let success):
                    
                    UserDefaultsManager.shared.token = success.accessToken
                    UserDefaultsManager.shared.refreshToken = success.refreshToken
                    completionHandler(success)
                
                case .failure:
                    print("로그인 실패")
                }
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func uploadImage(images: [UIImage], completionHandler: @escaping([String]) -> Void) {
        
        do {
            let request = try Router.uploadImage.asURLRequest()
            
            AF.upload(multipartFormData: { multipartFormData in
                
                for (index, item) in images.enumerated() {
                    guard let data = item.jpegData(compressionQuality: 0.5) else { return }
                    multipartFormData.append(data, withName: "files", fileName: "image\(index + 1).jpg", mimeType: "image/jpeg")
                }
                
            }, with: request)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: FilesModel.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.files ?? [])
                    
                case .failure(let error):
                    print(error)
                    print("fail uploadImage function")
                }
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func uploadPost(query: PostQuery, completionHandler: @escaping (PostModel) -> Void) {
        
        do {
            let request = try Router.uploadPost(query: query).asURLRequest()
            
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: PostModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        completionHandler(value)
                    case .failure(let error):
                        print(error)
                        print("upload 실패")
                    }
                }
            
        } catch {
            print(error, "uploadPost 실패")
        }
        
    }
    
    func deletePost(postId: String) {
        
        do {
            let request = try Router.deletePost(postId: postId).asURLRequest()
            
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ReadPostModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        dump(value.data)
                    case .failure(let error):
                        print(error)
                    }
                }
            
        } catch {
            print(error)
        }
        
    }
    
    func payments(postId: String, userId: String, completionHandler: @escaping (PaymentModel) -> Void) {
        
        do {
            let query = PaymentQuery(imp_uid: userId, post_id: postId)
            let request = try Router.payments(query: query).asURLRequest()
            
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: PaymentModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        completionHandler(value)
                        print("성공")
                    case .failure(let error):
                        print(error)
                        print("결제 실패")
                    }
                }
            
        } catch {
            print(error)
        }
        
    }
    
}

