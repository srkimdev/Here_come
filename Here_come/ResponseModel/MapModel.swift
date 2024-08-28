//
//  MapModel.swift
//  Here_come
//
//  Created by 김성률 on 8/28/24.
//

import Foundation

struct MapModel: Decodable {
    let documents: [AddressInfo]
}

struct AddressInfo: Decodable {
    let place_name: String
    let address_name: String
    let x: String
    let y: String
}
