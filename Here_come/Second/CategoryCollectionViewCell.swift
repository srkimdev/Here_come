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
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(contentView)
            make.size.equalTo(46)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.centerX.equalTo(contentView)
            make.top.equalTo(backView.snp.bottom).offset(8)
        }
    }
    
    override func configureUI() {
        backView.backgroundColor = .red
        backView.layer.masksToBounds = true
        
        categoryLabel.font = .systemFont(ofSize: 14)
        
    }
    
    func designCell(transition: Category) {
//        categoryImage
        categoryLabel.text = transition.name
        
    }

}
