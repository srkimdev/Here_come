//
//  ShowMapViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/28/24.
//

import UIKit
import SnapKit
import NMapsMap
import RxSwift

final class ShowMapViewController: BaseViewController {
    
    let naverMapView = NMFNaverMapView()
    let setButton = UIButton()
    
    var data: AddressInfo?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(naverMapView)
        view.addSubview(setButton)
    }
    
    override func configureLayout() {
        naverMapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        setButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(40)
        }
    }
    
    override func configureUI() {
        
        guard let data else { return }
        
        BackButton()
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(data.y) ?? 0, lng: Double(data.x) ?? 0))
        self.naverMapView.mapView.moveCamera(cameraUpdate)
        self.setMarker(lat: Double(data.y) ?? 0, lng: Double(data.x) ?? 0)
        
        setButton.setTitle("위치 설정하기", for: .normal)
        setButton.layer.cornerRadius = 5
        setButton.layer.masksToBounds = true
        setButton.backgroundColor = Custom.Colors.seaColor
        setButton.setTitleColor(.white, for: .normal)
        
    }
    
    private func setMarker(lat: Double, lng: Double) {
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = Custom.Colors.seaColor
        marker.width = 30
        marker.height = 40
        marker.mapView = self.naverMapView.mapView
        
    }
    
    func bind() {
        
        setButton.rx.tap
            .bind(with: self) { owner, _ in
                if let navigationController = self.navigationController {
                    let viewControllers = navigationController.viewControllers
                    if viewControllers.count >= 3 {
                        let targetViewController = viewControllers[viewControllers.count - 3]
                        
                        let vc = targetViewController as! WriteReviewViewController
                        vc.locationLabel.text = self.data?.place_name
//                        vc.address = self.data.
                        
                        navigationController.popToViewController(targetViewController, animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
    }
    
}
