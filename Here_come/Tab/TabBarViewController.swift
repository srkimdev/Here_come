//
//  TabBarViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = AccomodationViewController()
        let nav1 = UINavigationController(rootViewController: first)
        
        let second = RecommendViewController()
        let nav2 = UINavigationController(rootViewController: second)
        
        let third = FreeBoardViewController()
        let nav3 = UINavigationController(rootViewController: third)
        
        let fourth = ProfileManageViewController()
        let nav4 = UINavigationController(rootViewController: fourth)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        
    }
    
}
