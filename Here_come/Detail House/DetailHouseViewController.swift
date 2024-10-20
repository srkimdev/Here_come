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
import RxCocoa
import NMapsMap

final class DetailHouseViewController: BaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var houseImageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: houseImageCollectionViewLayout())
    let pageControl = UIPageControl()
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
    let naverMapView = NMFNaverMapView()
    let addressLabel = UILabel()
    
    let belowView = UIView()
    let likeButton = UIButton()
    let payButton = UIButton()
    
    var data: House?
    let networkTrigger = BehaviorRelay<House?>(value: nil)
    let viewModel = DetailHouseViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        houseImageCollectionView.register(HouseImageCollectionViewCell.self, forCellWithReuseIdentifier: HouseImageCollectionViewCell.identifier)
        
        setMarker()
        setupPageControl()
        bind()
    }
    
    override func configureHierarchy() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(houseImageCollectionView)
        contentView.addSubview(pageControl)
        contentView.addSubview(houseName)
        contentView.addSubview(locationLabel)
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
        contentView.addSubview(naverMapView)
        contentView.addSubview(addressLabel)
        view.addSubview(belowView)
        belowView.addSubview(likeButton)
        belowView.addSubview(payButton)
        
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
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(houseImageCollectionView.snp.bottom).inset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        houseName.snp.makeConstraints { make in
            make.top.equalTo(houseImageCollectionView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
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
        
        naverMapView.snp.makeConstraints { make in
            make.top.equalTo(locationInfoLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(180)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(naverMapView.snp.bottom).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalToSuperview().offset(-70)
        }
        
        belowView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(belowView.snp.leading).offset(16)
            make.centerY.equalTo(belowView)
            make.size.equalTo(40)
        }
        
        payButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(belowView).inset(10)
            make.trailing.equalTo(belowView).inset(16)
            make.width.equalTo(300)
        }
        
    }
    
    override func configureUI() {
        
        guard let data else { return }
        
        BackButton()
        
        scrollView.showsVerticalScrollIndicator = false
        
        houseName.text = data.title
        houseName.font = .systemFont(ofSize: 17)
        houseName.numberOfLines = 0
        
        houseImageCollectionView.isPagingEnabled = true
        houseImageCollectionView.showsHorizontalScrollIndicator = false
        
        locationLabel.text = data.location
        locationLabel.font = .systemFont(ofSize: 14)
        
        infoLabel.text = "정보 입력"
        infoLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        seperateLine.backgroundColor = .systemGray6
        
        dateInfoLabel.text = "날짜"
        dateInfoLabel.font = .systemFont(ofSize: 16)
        
        dateLabel.text = "2024. 08. 26 - 2024. 08. 29"
        dateLabel.font = .systemFont(ofSize: 16)
        
        dateEditButton.setTitle("수정하기", for: .normal)
        dateEditButton.setTitleColor(.lightGray, for: .normal)
        dateEditButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        personInfoLabel.text = "인원"
        personInfoLabel.font = .systemFont(ofSize: 16)
        
        personLabel.text = "1명"
        personLabel.font = .systemFont(ofSize: 16)
        
        personEditButton.setTitle("수정하기", for: .normal)
        personEditButton.setTitleColor(.lightGray, for: .normal)
        personEditButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        seperateLine2.backgroundColor = .systemGray6
        
        locationInfoLabel.text = "위치"
        locationInfoLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        naverMapView.layer.masksToBounds = true
        naverMapView.layer.cornerRadius = 5
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: data.latitude, lng: data.longitude))
        naverMapView.mapView.moveCamera(cameraUpdate)
        
        addressLabel.text = data.address
        addressLabel.font = .systemFont(ofSize: 14)
        
        belowView.backgroundColor = .white
        
        likeButton.setImage(HeartButton(), for: .normal)
        likeButton.contentMode = .scaleToFill
        likeButton.tintColor = Custom.Colors.seaColor
        
        payButton.setTitle("결제하기", for: .normal)
        payButton.layer.masksToBounds = true
        payButton.layer.cornerRadius = 20
        payButton.backgroundColor = Custom.Colors.seaColor
        
    }
    
    func bind() {
        
        guard let data else { return }
        
        let input = DetailHouseViewModel.Input(networkTrigger: networkTrigger)
        let output = viewModel.transform(input: input)
        
        output.imageArray
            .bind(to: houseImageCollectionView.rx.items(cellIdentifier: HouseImageCollectionViewCell.identifier, cellType: HouseImageCollectionViewCell.self)) {
                (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        payButton.rx.tap
            .bind(with: self) { owner, _ in
                let vc = PaymentViewController()
                vc.data = data
                
                owner.transitionScreen(vc: vc, style: .push)
            }
            .disposed(by: disposeBag)
        
        houseImageCollectionView.rx.contentOffset
            .map { [weak self] contentOffset in
                guard let self = self else { return 0 }
                
                let width = self.houseImageCollectionView.frame.width
                guard width > 0 else { return 0 }
                
                let pageIndex = round(contentOffset.x / width)
                return Int(pageIndex)
            }
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)
        
    }
    
    private func setMarker() {
        
        guard let data else { return }
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: data.latitude, lng: data.longitude)
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = Custom.Colors.seaColor
        marker.width = 30
        marker.height = 40
        marker.mapView = self.naverMapView.mapView
        
    }
    
    private func setupPageControl() {
        
        guard let data else { return }
        
        pageControl.numberOfPages = data.image.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = Custom.Colors.seaColor
        pageControl.pageIndicatorTintColor = .lightGray
        
    }
    
    private func HeartButton() -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "heart")?.withConfiguration(config)
        
        return image
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

