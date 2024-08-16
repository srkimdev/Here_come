//
//  SociallingViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift

final class SociallingViewController: BaseViewController {
    
    let topicTableView = UITableView()
    
    let viewModel = SociallingViewModel()
    let disposeBag = DisposeBag()
    
    let list = ["NEW", "추천 소셜링", "인기 소셜링"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTableView.register(SociallingTableViewCell.self, forCellReuseIdentifier: SociallingTableViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(topicTableView)
    }
    
    override func configureLayout() {
        topicTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        let item = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = item
        
        topicTableView.backgroundColor = .lightGray
        topicTableView.rowHeight = 250
        topicTableView.separatorStyle = .none
        
    }

    @objc func searchButtonTapped() {
        let vc = SearchViewController()
        transitionScreen(vc: vc, style: .push)
    }
    
    private func bind() {
        
        let viewDidLoadTrigger = Observable.just(())
        
        let input = SociallingViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger)
        let output = viewModel.transform(input: input)
        
        output.tableViewList
            .bind(to: topicTableView.rx.items(cellIdentifier: SociallingTableViewCell.identifier, cellType: SociallingTableViewCell.self)) { (row, element, cell) in

                cell.designCell(transition: self.list[row])
                
            }
            .disposed(by: disposeBag)
            
    }
    
}
