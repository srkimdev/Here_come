//
//  DetailHouseViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/26/24.
//

import UIKit
import SnapKit
import MapKit

final class DetailHouseViewController: BaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let houseImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: <#T##UICollectionViewLayout#>)
    let houseName = UILabel()
    let locationLabel = UILabel()
    
    let seperateLine = UIView()
    
    let infoLabel = UILabel()
    let dateInfoLabel = UILabel()
    let dateLabel = UILabel()
    let dateEditButton = UIButton()
    let personInfoLabel = UILabel()
    let personLabel = UILabel()
    let personEditButton = UIButton()
    
    let seperateLine2 = UIView()
    
    let locationInfoLabel = UILabel()
    let mapView = MKMapView()
    let addressLabel = UILabel()
    
    let likeButton = UIButton()
    
    var data: House?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(houseImage)
        contentView.addSubview(houseName)
        contentView.addSubview(locationLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(seperateLine)
        contentView.addSubview(infoLabel)
        contentView.addSubview(dateInfoLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(dateEditButton)
        contentView.addSubview(personInfoLabel)
        contentView.addSubview(personLabel)
        contentView.addSubview(personEditButton)
        contentView.addSubview(seperateLine2)
        contentView.addSubview(locationInfoLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(addressLabel)
        
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.verticalEdges.equalTo(scrollView)
        }
        
        houseImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        houseName.snp.makeConstraints { make in
            make.top.equalTo(houseImage.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).inset(30)
            make.height.equalTo(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(houseImage.snp.bottom).offset(14)
            make.trailing.equalTo(contentView).inset(16)
            make.size.equalTo(36)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(houseName.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(2)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        dateInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dateInfoLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        dateEditButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(20)
        }
        
        personInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        personLabel.snp.makeConstraints { make in
            make.top.equalTo(personInfoLabel.snp.bottom).offset(12)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        personEditButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }
        
        seperateLine2.snp.makeConstraints { make in
            make.top.equalTo(personLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(2)
        }
        
        locationInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLine2.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(20)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(locationInfoLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(180)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
    
    override func configureUI() {
        
        guard let data else { return }
        
        houseImage.backgroundColor = .lightGray
        
        houseName.text = "오크우드 프리미어 인천"
        houseName.font = .systemFont(ofSize: 17)
        
        locationLabel.text = "제주시 애월읍"
        locationLabel.font = .systemFont(ofSize: 14)
        
        likeButton.configuration = .HeartButton()
        
        infoLabel.text = "정보 입력"
        infoLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        seperateLine.backgroundColor = .systemGray5
        
        dateInfoLabel.text = "날짜"
        dateInfoLabel.font = .systemFont(ofSize: 16)
        
        dateLabel.text = "2024. 08. 26 - 2024. 08. 29"
        
        dateEditButton.setTitle("수정하기", for: .normal)
        dateEditButton.setTitleColor(.black, for: .normal)
        
        personInfoLabel.text = "인원"
        personInfoLabel.font = .systemFont(ofSize: 16)
        
        personLabel.text = "1명"
        
        personEditButton.setTitle("수정하기", for: .normal)
        personEditButton.setTitleColor(.black, for: .normal)
        
        seperateLine2.backgroundColor = .systemGray5
        
        locationInfoLabel.text = "위치"
        locationInfoLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        mapView.layer.masksToBounds = true
        mapView.layer.cornerRadius = 5
        mapView.backgroundColor = .lightGray
        
        addressLabel.text = "인천광역시 연수구 컨벤시아대로 165"
        addressLabel.font = .systemFont(ofSize: 14)
        
    }
    
}

extension DetailHouseViewController: UICollectionViewDelegateFlowLayout {
    func houseImageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        
    }
}

