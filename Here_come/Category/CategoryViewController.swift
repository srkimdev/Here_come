//
//  CategoryViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import UIKit
import SnapKit
import RxSwift

final class CategoryViewController: BaseViewController {
    
    let mainTitle = UILabel()
    let categoryTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(mainTitle)
        view.addSubview(categoryTableView)
        view.addSubview(categoryCollectionView)
    }
    
    override func configureLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
        
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        mainTitle.text = "게시글 카테고리를 선택해주세요."
        mainTitle.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    func bind() {
        
    }
    
}

