//
//  CategoryCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/17/24.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let categoryImage = UIImageView()
    let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backView.layer.cornerRadius = backView.frame.width / 2
        categoryImage.layer.cornerRadius = categoryImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(contentView)
            make.size.equalTo(54)
        }
        
        categoryImage.snp.makeConstraints { make in
            make.center.equalTo(backView)
            make.size.equalTo(backView).multipliedBy(0.8)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom).offset(4)
            make.centerX.equalTo(contentView)
        }
    }
    
    override func configureUI() {
        
        backView.layer.masksToBounds = true
        backView.layer.borderColor = UIColor.black.cgColor
        
        categoryImage.layer.masksToBounds = true
        categoryImage.backgroundColor = .red
        
        categoryLabel.font = .systemFont(ofSize: 14)
        
    }
    
    func designCell(transition: Int, selectedIndex: Int) {

        if transition == selectedIndex {
            backView.layer.borderWidth = 1
        } else {
            backView.layer.borderWidth = 0
        }
        
        categoryLabel.text = categories[transition].name
        
    }

}
