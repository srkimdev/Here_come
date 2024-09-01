//
//  FreeBoardViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SellingViewController: BaseViewController {
    
    lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 70, height: 0))
    let recentLabel = UILabel()
    let deleteButton = UIButton()
    
    let totalLabel = UILabel()
    
    let dateButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black

        var attText = AttributedString("날짜순")
        attText.font = UIFont.systemFont(ofSize: 15)
        configuration.attributedTitle = attText
        configuration.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        configuration.background.cornerRadius = 12
        configuration.background.strokeColor = .lightGray
        configuration.background.strokeWidth = 1
        
        button.configuration = configuration
        
        return button
    }()
    
    lazy var recentTextCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentTextCollectionViewLayout())
    lazy var houseCollectionView = UICollectionView(frame: .zero, collectionViewLayout: houseCollectionViewLayout())
    
    let viewModel = SellingViewModel()
    let disposeBag = DisposeBag()
    let networkTrigger = PublishSubject<Void>()
    let inputText = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
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
            make.height.equalTo(24)
        }
        
        houseCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(16)
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
        
        recentTextCollectionView.showsHorizontalScrollIndicator = false
        
        houseCollectionView.showsVerticalScrollIndicator = false
        
    }
    
    func bind() {
        
        let cellDeleteButton = PublishSubject<Int>()
        
        let input = SellingViewModel.Input(networkTrigger: networkTrigger, inputText: inputText, deleteAllButtonTap: deleteButton.rx.tap, cellDeleteButton: cellDeleteButton)
        let output = viewModel.transform(input: input)
        
        output.updateTableView
            .bind(to: houseCollectionView.rx.items(cellIdentifier: HouseCollectionViewCell.identifier, cellType: HouseCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        output.updateRecentText
            .observe(on: MainScheduler.instance)
            .bind(to: recentTextCollectionView.rx.items(cellIdentifier: RecentTextCollectionViewCell.identifier, cellType: RecentTextCollectionViewCell.self)) { (item, element, cell) in

                cell.designCell(transition: element)
                
                cell.deleteButton.rx.tap
                    .bind(with: self) { owner, _ in
                        cellDeleteButton.onNext(item)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        houseCollectionView.rx.modelSelected(House.self)
            .bind(with: self) { owner, value in
                
                let vc = DetailHouseViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.data = value
                vc.networkTrigger.accept(value)
                
                owner.transitionScreen(vc: vc, style: .push)
                
            }
            .disposed(by: disposeBag)
        
        networkTrigger.onNext(())
        
    }
    
}

extension SellingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        inputText.onNext(searchText)
    }
}

extension SellingViewController: UICollectionViewDelegateFlowLayout {
    
    func houseCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width / 2 - 2
        layout.itemSize = CGSize(width: width, height: width * 2 - 20)
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func recentTextCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return layout
    }
    
}
