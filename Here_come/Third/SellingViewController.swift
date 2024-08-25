//
//  FreeBoardViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift

final class SellingViewController: BaseViewController {
    
    lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 70, height: 0))
    let recentLabel = UILabel()
    let deleteButton = UIButton()
    
    let totalLabel = UILabel()
    let dateButton = UIButton()
    
    lazy var recentTextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentTextCollectionViewLayout())
    lazy var houseCollectionView = UICollectionView(frame: .zero, collectionViewLayout: houseCollectionViewLayout())
    
    let viewModel = SellingViewModel()
    let disposeBag = DisposeBag()
    let networkTrigger = PublishSubject<Void>()
    
    let list = ["밥", "된장찌개", "계란말이", "교촌허니콤보", "떡볶이"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentTextCollectionView.delegate = self
        recentTextCollectionView.dataSource = self
        recentTextCollectionView.register(RecentTextCollectionViewCell.self, forCellWithReuseIdentifier: RecentTextCollectionViewCell.identifier)
        houseCollectionView.register(HouseCollectionViewCell.self, forCellWithReuseIdentifier: HouseCollectionViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        
        view.addSubview(recentLabel)
        view.addSubview(deleteButton)
        view.addSubview(recentTextCollectionView)
        view.addSubview(totalLabel)
        view.addSubview(dateButton)
        view.addSubview(houseCollectionView)
        
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
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(recentTextCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(recentTextCollectionView.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        houseCollectionView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        
        searchBar.placeholder = "관심사, 태그, 지역명을 검색해 보세요"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        recentLabel.text = "최근 검색어"
        recentLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        deleteButton.setTitle("모두 지우기", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 14)
        deleteButton.tintColor = .black
        
        totalLabel.text = "총 234개"
        totalLabel.font = .systemFont(ofSize: 15)
        
        dateButton.setTitle("날짜", for: .normal)
        dateButton.setTitleColor(.black, for: .normal)
        dateButton.layer.cornerRadius = 10
        dateButton.layer.masksToBounds = true
        dateButton.layer.borderWidth = 1
        
    }
    
    func bind() {
        
        let input = SellingViewModel.Input(networkTrigger: networkTrigger)
        let output = viewModel.transform(input: input)
        
        output.updateTableView
            .bind(to: houseCollectionView.rx.items(cellIdentifier: HouseCollectionViewCell.identifier, cellType: HouseCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        networkTrigger.onNext(())
        
    }
    
}

extension SellingViewController: UICollectionViewDelegateFlowLayout {
    
    func houseCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width / 2 - 2
        layout.itemSize = CGSize(width: width, height: width * 2)
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func recentTextCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        return layout
    }
    
}

extension SellingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentTextCollectionView.dequeueReusableCell(withReuseIdentifier: RecentTextCollectionViewCell.identifier, for: indexPath) as! RecentTextCollectionViewCell
        
        cell.designCell(transition: list[indexPath.row])
        
        return cell
    }
}
