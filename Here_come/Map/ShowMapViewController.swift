//
//  ShowMapViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/25/24.
//

import UIKit
import SnapKit
import MapKit
import NMapsMap
import RxSwift

final class ShowMapViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let naverMapView = NMFNaverMapView()
    let locationTableView = UITableView()
    
    let disposeBag = DisposeBag()
    let viewModel = ShowMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
        
        bind()
        
    }
    
    override func configureHierarchy() {

        view.addSubview(searchBar)
//        view.addSubview(naverMapView)
        view.addSubview(locationTableView)
        
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
        
//        naverMapView.snp.makeConstraints { make in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
//        }
        
        locationTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        
        searchBar.placeholder = "숙소의 주소, 지역명 등을 입력해주세요"
        
        locationTableView.rowHeight = 80
        
    }
    
    func bind() {
        
        let input = ShowMapViewModel.Input(inputText: searchBar.rx.text.orEmpty, searchBarEnter: searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.addressInfo
            .bind(to: locationTableView.rx.items(cellIdentifier: LocationTableViewCell.identifier, cellType: LocationTableViewCell.self)) { (row, element, cell) in
                
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(element.x) ?? 0, lng: Double(element.y) ?? 0))
                self.naverMapView.mapView.moveCamera(cameraUpdate)
                self.setMarker(lat: Double(element.x) ?? 0, lng: Double(element.y) ?? 0)
                
                cell.designCell(transition: element.place_name)
                
            }
            .disposed(by: disposeBag)
        
        locationTableView.rx.modelSelected(AddressInfo.self)
            .bind(with: self) { owner, value in
                
                
                
            }
            .disposed(by: disposeBag)
                                                   
    }
    
    private func setMarker(lat: Double, lng: Double) {
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = UIColor.red
        marker.width = 30
        marker.height = 40
        marker.mapView = self.naverMapView.mapView
        
    }
    
}

