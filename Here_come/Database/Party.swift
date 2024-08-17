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

enum Category: String, CaseIterable {
    case all = "전체"
    case surfing = "서핑"
    case hiking = "등산"
    case camping
    case riding
    case running
    case fishing
    case driving
}


let list = ["NEW", "추천 소셜링", "인기 소셜링"]

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
