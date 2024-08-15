//
//  NetworkManager.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func accessLogin(id: String, password: String, completionHandler: @escaping (LoginModel) -> Void) {
        
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
                    print("실패")
                }
            }
            
        } catch {
            print(error)
        }
        
    }
    
    
    
}
