//
//  ReusableProtocol.swift
//  Here_come
//
//  Created by 김성률 on 8/15/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
