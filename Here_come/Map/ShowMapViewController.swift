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

final class ShowMapViewController: BaseViewController {
    
    let searchBar = UISearchBar()
    let mapView = NMFMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.delegate = self
        
            
        
    }
    
    override func configureHierarchy() {

//        view.addSubview(searchBar)
        view.addSubview(mapView)
        
    }
    
    override func configureLayout() {
        
//        searchBar.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
//            make.height.equalTo(44)
//        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    
    override func configureUI() {
        
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "숙소의 주소, 지역명 등을 입력해주세요"
        
    }
    
    
}
