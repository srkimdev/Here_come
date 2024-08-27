//
//  DetailHouseViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/26/24.
//

import UIKit
import SnapKit
import MapKit
import RxSwift

final class DetailHouseViewController: BaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var houseImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: houseImageCollectionViewLayout())
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
    let networkTrigger = BehaviorSubject<House?>(value: nil)
    let viewModel = DetailHouseViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        houseImageCollectionView.register(HouseImageCollectionViewCell.self, forCellWithReuseIdentifier: HouseImageCollectionViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(houseImageCollectionView)
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
        
        houseImageCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(250)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(houseImageCollectionView.snp.bottom).offset(14)
            make.trailing.equalTo(contentView).inset(16)
            make.size.equalTo(36)
        }
        
        houseName.snp.makeConstraints { make in
            make.top.equalTo(houseImageCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(likeButton.snp.leading).offset(-16)
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
        
        houseName.text = data.title
        houseName.font = .systemFont(ofSize: 17)
        houseName.numberOfLines = 0
        
        houseImageCollectionView.isPagingEnabled = true
        houseImageCollectionView.showsHorizontalScrollIndicator = false
        
        locationLabel.text = data.location
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
    
    func bind() {
        
        let input = DetailHouseViewModel.Input(networkTrigger: networkTrigger)
        let output = viewModel.transform(input: input)
        
        output.imageArray
            .bind(to: houseImageCollectionView.rx.items(cellIdentifier: HouseImageCollectionViewCell.identifier, cellType: HouseImageCollectionViewCell.self)) {
                (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension DetailHouseViewController: UICollectionViewDelegateFlowLayout {
    func houseImageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}

