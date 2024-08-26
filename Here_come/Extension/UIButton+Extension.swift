//
//  UIButton+Extension.swift
//  Here_come
//
//  Created by 김성률 on 8/26/24.
//

import UIKit

extension UIButton.Configuration {
    
    static func HeartButton() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "heart")
        config.buttonSize = .large
        config.image?.withTintColor(.black)
        return config
    }
    
}
