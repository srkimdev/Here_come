//
//  UIViewController+Extension.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFull
        case push
    }
    
    func transitionScreen<T: UIViewController>(vc: T, style: TransitionStyle) {
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFull:
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
