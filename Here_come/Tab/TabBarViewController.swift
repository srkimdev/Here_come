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
        
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
        
        let first = AccomodationViewController()
        let nav1 = UINavigationController(rootViewController: first)
        nav1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "home.fill"))
        
        let second = SociallingViewController()
        let nav2 = UINavigationController(rootViewController: second)
        nav2.tabBarItem = UITabBarItem(title: "소셜링", image: UIImage(systemName: "leaf"), selectedImage: UIImage(systemName: "leaf.fill"))
        
        let third = SellingViewController()
        let nav3 = UINavigationController(rootViewController: third)
        nav3.tabBarItem = UITabBarItem(title: "숙소검색", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        let fourth = ProfileManageViewController()
        let nav4 = UINavigationController(rootViewController: fourth)
        nav4.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
        
    }
    
}
