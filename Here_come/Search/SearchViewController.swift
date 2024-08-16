//
//  SearchViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit
import RxSwift

final class SearchViewController: BaseViewController {
    
    lazy var recentTextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentTextCollectionViewLayout())
//    lazy var recommendTextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recommendTextCollectionViewLayout())
    
    lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 70, height: 0))
    let recentLabel = UILabel()
    let deleteButton = UIButton()
    let recommendLabel = UILabel()
    
    let list = ["밥", "된장찌개", "계란말이", "교촌허니콤보", "떡볶이"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentTextCollectionView.delegate = self
        recentTextCollectionView.dataSource = self
        recentTextCollectionView.register(RecentTextCollectionViewCell.self, forCellWithReuseIdentifier: RecentTextCollectionViewCell.identifier)
//        recommendTextCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        
        bind()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(recentLabel)
        view.addSubview(deleteButton)
        view.addSubview(recentTextCollectionView)
        view.addSubview(recommendLabel)
    }
    
    override func configureLayout() {
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(30)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentLabel)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
        
        recentTextCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recentLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(28)
        }
        
//        recommendLabel.snp.makeConstraints { make in
//            make.top.equalTo(recentTextCollectionView.snp.bottom).offset(16)
//            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
//            make.height.equalTo(30)
//        }
//
//        recommendTextCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(recommendLabel.snp.bottom).offset(16)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
//        }
        
    }
    
    override func configureUI() {
        
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        item.tintColor = .black
        navigationItem.leftBarButtonItem = item
        
        searchBar.placeholder = "관심사, 태그, 지역명을 검색해 보세요"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        recentLabel.text = "최근 검색어"
        recentLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        deleteButton.setTitle("모두 지우기", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 14)
        deleteButton.tintColor = .black
        
//        recommendLabel.text = "추천 검색어"
//        recommendLabel.font = .systemFont(ofSize: 16, weight: .bold)

    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func bind() {
        
//        Observable.just(list)
//            .bind(to: recommendTextCollectionView.rx.items(cellIdentifier: RecommendCollectionViewCell.identifier, cellType: RecommendCollectionViewCell.self)) { (item, element, cell) in
//
//                cell.designCell(transition: element)
//
//            }
//            .disposed(by: disposeBag)
        
        searchBar.rx.textDidBeginEditing
            .bind(with: self) { owner, _ in
//                owner.recentLabel.isHidden = true
//                owner.deleteButton.isHidden = true
//                owner.recentTextCollectionView.isHidden = true
            }
            .disposed(by: disposeBag)
        
    }

}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func recentTextCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        return layout
    }
    
//    func recommendTextCollectionViewLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 8
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        return layout
//    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentTextCollectionView.dequeueReusableCell(withReuseIdentifier: RecentTextCollectionViewCell.identifier, for: indexPath) as! RecentTextCollectionViewCell
        
        cell.designCell(transition: list[indexPath.row])
        
        return cell
    }
}
