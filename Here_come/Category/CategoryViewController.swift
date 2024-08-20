//
//  CategoryViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CategoryViewController: BaseViewController {
    
    let mainTitle = UILabel()
    let categoryTableView = UITableView()
    
    let disposeBag = DisposeBag()
    let viewModel = CategoryViewModel()
    let showTrigger = PublishSubject<Void>()
    
    var categoryClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(mainTitle)
        view.addSubview(categoryTableView)
    }
    
    override func configureLayout() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
        
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        mainTitle.text = "게시글 카테고리를 선택해주세요."
        mainTitle.font = .systemFont(ofSize: 20, weight: .bold)
        
        categoryTableView.rowHeight = 160
        categoryTableView.separatorStyle = .none
    }
    
    func bind() {
        
        let input = CategoryViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.tableViewList
            .bind(to: categoryTableView.rx.items(cellIdentifier: CategoryTableViewCell.identifier, cellType: CategoryTableViewCell.self)) { (row, element, cell) in
                
                cell.designCell(transition: element, selectedValue: self.viewModel.selectedValue.value, row: row)
                
                cell.categoryCollectionView.rx.modelSelected(String.self)
                    .bind(with: self) { owner, value in

                        owner.viewModel.selectedValue.accept(value)
                        owner.categoryClosure?(value)
                        
                        owner.dismissWithDelay(delay: 2.0)
                        
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
    }
    
}

