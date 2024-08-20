//
//  CategoryCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(categoryLabel)
    }
    
    override func configureLayout() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.center.equalTo(backView)
        }
    }
    
    override func configureUI() {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 18
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.systemGray4.cgColor
        
    }
    
    func designCell(transition: String, selectedValue: String) {
        categoryLabel.text = transition
        
        if transition == selectedValue {
            backView.backgroundColor = .black
            categoryLabel.textColor = .white
        } else {
            backView.backgroundColor = .white
            categoryLabel.textColor = .black
        }
    
    }
    
    
}
