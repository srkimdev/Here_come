//
//  HouseCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/25/24.
//

import UIKit
import SnapKit
import RxSwift

final class HouseCollectionViewCell: BaseCollectionViewCell {
    
    let houseImage = UIImageView()
    let locationLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let startStackView = StarRatingView()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        
        contentView.addSubview(houseImage)
        contentView.addSubview(locationLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(startStackView)
        
    }
    
    override func configureLayout() {
        
        houseImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView.bounds.width)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(houseImage.snp.bottom).offset(12)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        startStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(startStackView.snp.bottom).offset(12)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(20)
        }
        
    }
    
    override func configureUI() {
        
        houseImage.backgroundColor = .lightGray
        
        locationLabel.text = "제주시 애월읍"
        locationLabel.textColor = .lightGray
        locationLabel.font = .systemFont(ofSize: 14)
        
        titleLabel.text = "독채 펜션 불명 바베큐 동쪽"
        titleLabel.numberOfLines = 2
        
        priceLabel.text = "200,000원"
        
    }
    
    func designCell(transition: House) {
        
    }
    
}
