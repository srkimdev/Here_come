//
//  PaymentModel.swift
//  Here_come
//
//  Created by 김성률 on 8/29/24.
//

import Foundation

struct PaymentModel: Decodable {
//    let buyers: [String]
    let buyer_id: String
    let post_id: String
    let merchant_uid: String
    let productName: String
    let price: Int
    let paidAt: String
}
