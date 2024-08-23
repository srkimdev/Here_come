//
//  Party.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import Foundation

struct Party {
    let Photos: [String]
    let whom: String
    let place: String
    let time: String
    let activity: String
    let explanation: String
}

//struct Category {
//    let image: String
//    let name: String
//}

let Parties: [Party] = [
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: ""),
     Party(Photos: [],
           whom: "",
           place: "",
           time: "",
           activity: "",
           explanation: "")
    
]

enum Categories: String, CaseIterable {
    case all = "전체"
    case surfing = "서핑"
    case hiking = "등산"
    case camping = "캠핑"
    case running = "러닝"
    case fishing = "낚시"
    case driving = "드라이브"
    
    var imageIcon: String {
        switch self {
        case .all:
            return "all"
        case .surfing:
            return "surfing"
        case .hiking:
            return "hiking"
        case .camping:
            return "camping"
        case .running:
            return "running"
        case .fishing:
            return "fishing"
        case .driving:
            return "driving"
        }
    }
}

