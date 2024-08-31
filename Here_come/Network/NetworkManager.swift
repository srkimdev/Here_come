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
            
            AF.request(request, interceptor: AuthInterceptor())
            .validate(statusCode: 200..<300)
            .responseDecodable(of: responseType) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure:
                    let statusCode: Int = response.response?.statusCode ?? 0
                    let error = APIError.statusCodeCheck(statusCode: statusCode)
                    print("callRequest ->", error.description)
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
                    let statusCode: Int = response.response?.statusCode ?? 0
                    let error = APIError.statusCodeCheck(statusCode: statusCode)
                    print("callRequest ->", error.description)
                }
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func accessToken(completionHandler: @escaping (Result<TokenModel, APIError>) -> Void) {
        
        do {
            let request = try Router.accessToken.asURLRequest()
            
            AF.request(request).responseDecodable(of: TokenModel.self) { response in
                switch response.result {
                case .success(let success):
                    
                    print("accessToken refresh")
                    completionHandler(.success(success))
                
                case .failure:
                    let statusCode: Int = response.response?.statusCode ?? 0
                    let error = APIError.statusCodeCheck(statusCode: statusCode)
                    print("callRequest ->", error.description)
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
                    
                case .failure:
                    let statusCode: Int = response.response?.statusCode ?? 0
                    let error = APIError.statusCodeCheck(statusCode: statusCode)
                    print("callRequest ->", error.description)
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
                    case .failure:
                        let statusCode: Int = response.response?.statusCode ?? 0
                        let error = APIError.statusCodeCheck(statusCode: statusCode)
                        print("callRequest ->", error.description)
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
                    case .failure:
                        let statusCode: Int = response.response?.statusCode ?? 0
                        let error = APIError.statusCodeCheck(statusCode: statusCode)
                        print("callRequest ->", error.description)
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
                    case .failure:
                        let statusCode: Int = response.response?.statusCode ?? 0
                        let error = APIError.statusCodeCheck(statusCode: statusCode)
                        print("callRequest ->", error.description)
                    }
                }
            
        } catch {
            print(error)
        }
        
    }
    
}

final class AuthInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {

        var urlRequest = urlRequest
        print("enter adapt", UserDefaultsManager.shared.token)
        urlRequest.setValue(UserDefaultsManager.shared.token, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419 else {
            print("it's not 401")
            completion(.doNotRetryWithError(error))
            return
        }

        print("accessToken 401 --> try accessToken refresh")
            
        NetworkManager.shared.accessToken { response in
            switch response {
            case .success(let value):
                
                print(value.accessToken)
                UserDefaultsManager.shared.token = value.accessToken
                completion(.retry)
                
            case .failure(let error):
                print("Refresh Token is expired, \(error)")
                completion(.doNotRetryWithError(error))
                self.initialize()
            }
        }

    }
    
    private func initialize() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
//        let rootViewcontroller = UINavigationController(rootViewController: )
        
        sceneDelegate?.window?.rootViewController = LoginViewController()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
}

