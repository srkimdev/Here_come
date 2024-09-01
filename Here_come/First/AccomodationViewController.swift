//
//  AccomodationViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AccomodationViewController: BaseViewController {
    
    let viewModel = AccomodationViewModel()
    let disposeBag = DisposeBag()
    
    let networkTrigger = BehaviorSubject<Void>(value: ())
    let pullToRefresh = PublishSubject<Void>()
    
    let postTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.register(AccomodationTableViewCell.self, forCellReuseIdentifier: AccomodationTableViewCell.identifier)
        
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
        postTableView.showsVerticalScrollIndicator = false
        postTableView.separatorInset = UIEdgeInsets.zero
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("updatePost"), object: nil)
        
    }
    
    func bind() {
        
        let likeButtonTap = BehaviorRelay<String>(value: "")
        let showDeleteAlert = PublishSubject<String>()
        
        let input = AccomodationViewModel.Input(networkTrigger: networkTrigger, likeButtonTap: likeButtonTap, showDeleteAlert: showDeleteAlert)
        let output = viewModel.transform(input: input)
        
        output.tableViewList
            .bind(to: postTableView.rx.items(cellIdentifier: AccomodationTableViewCell.identifier, cellType: AccomodationTableViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
                cell.commentButton.rx.tap
                    .bind(with: self) { owner, _ in
                        
                        let vc = CommentViewController()
                        
                        vc.viewModel.networkTrigger.accept(element.post_id)
                        
                        if let sheet = vc.sheetPresentationController {
                            sheet.detents = [.large()]
                            sheet.prefersGrabberVisible = true
                        }
                        
                        owner.transitionScreen(vc: vc, style: .present)
                        
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        likeButtonTap.accept(element.post_id)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.settingButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.showDeleteAlert() {
                            showDeleteAlert.onNext(element.post_id)
                        }
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
//        output.updateLike
//            .bind(with: self) { owner, _ in
//                owner.networkTrigger.onNext(())
//            }
//            .disposed(by: disposeBag)
        
    }

    @objc func writeButtonTapped() {
        let vc = WriteReviewViewController()
        transitionScreen(vc: vc, style: .push)
    }
    
    @objc func receivedNotification() {
        networkTrigger.onNext(())
    }
    
}



