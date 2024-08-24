//
//  ExtractSentence.swift
//  Here_come
//
//  Created by 김성률 on 8/24/24.
//

import Foundation

final class ExtractSentence {
    
    static let shared = ExtractSentence()
    
    private init() { }
    
    func splitString(_ input: String) -> [String] {
        let components = input.split(separator: "_")
        return components.map { String($0) }
    }
    
}
