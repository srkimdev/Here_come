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
    
    lazy var sociallingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: sociallingCollectionViewLayout())
    let topicTableView = UITableView()
    
    let viewModel = SociallingViewModel()
    let disposeBag = DisposeBag()
    
    let refreshControl = UIRefreshControl()
    let networkTrigger = BehaviorSubject<Void>(value: ())
    let pullToRefresh = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sociallingCollectionView.register(SociallingCollectionViewCell.self, forCellWithReuseIdentifier: SociallingCollectionViewCell.identifier)
        topicTableView.register(SociallingTableViewCell.self, forCellReuseIdentifier: SociallingTableViewCell.identifier)
        topicTableView.refreshControl = refreshControl
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkTrigger.onNext(())
    }
    
    override func configureHierarchy() {
        view.addSubview(sociallingCollectionView)
        view.addSubview(topicTableView)
    }
    
    override func configureLayout() {
        
        sociallingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(110)
        }
        
        topicTableView.snp.makeConstraints { make in
            make.top.equalTo(sociallingCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
        
    override func configureUI() {
        let item = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(searchButtonTapped))
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        sociallingCollectionView.backgroundColor = .lightGray
        
        topicTableView.rowHeight = 120
        
    }
    
    override func configureAction() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc func searchButtonTapped() {
        let vc = WriteViewController()
        transitionScreen(vc: vc, style: .push)
    }
    
    @objc func refreshData() {
        pullToRefresh.onNext(())
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func bind() {
        
        let input = SociallingViewModel.Input(networkTrigger: networkTrigger, pullToRefresh: self.pullToRefresh)
        let output = viewModel.transform(input: input)
        
        output.tableViewList
            .bind(to: topicTableView.rx.items(cellIdentifier: SociallingTableViewCell.identifier, cellType: SociallingTableViewCell.self)) { (row, element, cell) in

                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        output.collectionViewList
            .bind(to: sociallingCollectionView.rx.items(cellIdentifier: SociallingCollectionViewCell.identifier, cellType: SociallingCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: item, selectedIndex: self.viewModel.selectedIndexPath.value)
                
            }
            .disposed(by: disposeBag)
        
        sociallingCollectionView.rx.itemSelected
            .map { indexPath in indexPath.row }
            .bind(with: self) { owner, value in
                
                owner.viewModel.selectedIndexPath.accept(value)
                owner.sociallingCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
            
    }
    
}

extension SociallingViewController: UICollectionViewDelegateFlowLayout {
    func sociallingCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 110)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        return layout
    }
}
