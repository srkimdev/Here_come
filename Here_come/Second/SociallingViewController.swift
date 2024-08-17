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
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryCollectionViewLayout())
    let topicTableView = UITableView()
    
    let viewModel = SociallingViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        topicTableView.register(SociallingTableViewCell.self, forCellReuseIdentifier: SociallingTableViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(categoryCollectionView)
        view.addSubview(topicTableView)
    }
    
    override func configureLayout() {
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        topicTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        let item = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(searchButtonTapped))
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        categoryCollectionView.backgroundColor = .lightGray
        
        topicTableView.rowHeight = 120
        
        
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

                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        output.collectionViewList
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryCollectionViewCell.identifier, cellType: CategoryCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
            
    }
    
}

extension SociallingViewController: UICollectionViewDelegateFlowLayout {
    func categoryCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        return layout
    }
}
