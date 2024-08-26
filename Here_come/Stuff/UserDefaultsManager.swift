//
//  UserDefaultsManager.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation

final class UserDefaultsManager {
    
    private enum UserDefaultsKey: String {
        case access
        case refresh
    }
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    var token: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKey.access.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.access.rawValue)
        }
    }
    
    var refreshToken: String {
        get {
            UserDefaults.standard.string(forKey: UserDefaultsKey.refresh.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.refresh.rawValue)
        }
    }
    
    var searchTextStore: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "searchTextStore") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "searchTextStore")
        }
    }
    
}
