//
//  BaseViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        view.backgroundColor = .white
        
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureUI() { }
    
    func configureAction() { }
    
}
