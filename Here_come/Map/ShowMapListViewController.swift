//
//  ShowMapViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/25/24.
//

import UIKit
import SnapKit
import MapKit
import RxSwift

final class ShowMapListViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let locationTableView = UITableView()
    
    let disposeBag = DisposeBag()
    let viewModel = ShowMapListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        
        bind()
        
    }
    
    override func configureHierarchy() {

        view.addSubview(searchBar)
        view.addSubview(locationTableView)
        
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
        
        locationTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        
        BackButton()
        searchBar.placeholder = "숙소의 주소, 지역명 등을 입력해주세요"
        
        locationTableView.rowHeight = 80
        
    }
    
    func bind() {
        
        let input = ShowMapListViewModel.Input(inputText: searchBar.rx.text.orEmpty, searchBarEnter: searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.addressInfo
            .bind(to: locationTableView.rx.items(cellIdentifier: LocationTableViewCell.identifier, cellType: LocationTableViewCell.self)) { (row, element, cell) in
                
                cell.designCell(transition: element.place_name)
                
            }
            .disposed(by: disposeBag)
        
        locationTableView.rx.modelSelected(AddressInfo.self)
            .bind(with: self) { owner, value in
                
                let vc = ShowMapViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.data = value
                
                owner.transitionScreen(vc: vc, style: .push)
            }
            .disposed(by: disposeBag)
                                                   
    }
    
}

