//
//  UIButton+Extension.swift
//  Here_come
//
//  Created by 김성률 on 8/26/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func filterButton() -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "날짜순"
        configuration.baseForegroundColor = .black
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        configuration.baseBackgroundColor = .white
        return configuration
    }

}
