//
//  AccomodationViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift

final class AccomodationViewController: BaseViewController {
    
    let viewModel = AccomodationViewModel()
    let disposeBag = DisposeBag()
    
    let networkTrigger = BehaviorSubject<Void>(value: ())
    let pullToRefresh = PublishSubject<Void>()
    
    let postTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.register(AccomodationTableViewCell.self, forCellReuseIdentifier: AccomodationTableViewCell.identifier)
        
//        NetworkManager.shared.deletePost(postId: "66c97139078fb670167c4231")
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(postTableView)
    }
    
    override func configureLayout() {
        postTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        let item = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(writeButtonTapped))
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        postTableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("updatePost"), object: nil)
        
    }
    
    func bind() {
        
        let input = AccomodationViewModel.Input(networkTrigger: networkTrigger, pullToRefresh: pullToRefresh)
        let output = viewModel.transform(input: input)
        
        output.collectionViewList
            .bind(to: postTableView.rx.items(cellIdentifier: AccomodationTableViewCell.identifier, cellType: AccomodationTableViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        networkTrigger.onNext(())
        
    }
    
    @objc func writeButtonTapped() {
        let vc = WriteReviewViewController()
        transitionScreen(vc: vc, style: .push)
    }
    
    @objc func receivedNotification() {
        networkTrigger.onNext(())
    }
    
}



