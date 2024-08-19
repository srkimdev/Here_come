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
    
    func uploadPost(query: PostQuery) {
        
        do {
            let request = try Router.uploadPost(query: query).asURLRequest()
            
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: PostModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                    case .failure(let error):
                        print(error)
                    }
                }
            
        } catch {
            print(error, "uploadPost 실패")
        }
        
    }
    
    func readPost(productId: String, completionHandler: @escaping ([Posts]) -> Void) {
        
        do {
            let request = try Router.readPost(productId: productId).asURLRequest()
            
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ReadPostModel.self) { response in
                    switch response.result {
                    case .success(let value):
                        dump(value.data)
                        completionHandler(value.data)
                    case .failure(let error):
                        print(error)
                    }
                }
            
        } catch {
            print(error)
        }
        
    }
    
}
