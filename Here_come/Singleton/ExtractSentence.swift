//
//  ExtractSentence.swift
//  Here_come
//
//  Created by 김성률 on 8/22/24.
//

import Foundation

final class ExtractSentence {
    
    static let shared = ExtractSentence()
    
    private init() { }
    
    func extractID(inputString: String) -> String {
        let components = inputString.split(separator: "_")
        let extractedString = String(components[1])
        
        return extractedString
    }
    
}
