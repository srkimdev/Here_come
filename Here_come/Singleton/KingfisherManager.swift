//
//  KingfisherManager.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import Foundation
import Kingfisher

final class KingfisherManager {
    
    static let shared = KingfisherManager()
    
    private init() { }
    
    let modifier = AnyModifier { request in
        var req = request
        req.setValue(UserDefaultsManager.shared.token, forHTTPHeaderField: Header.authorization.rawValue)
        req.setValue(APIKey.Key, forHTTPHeaderField: Header.sesacKey.rawValue)
        return req
    }
    
}
