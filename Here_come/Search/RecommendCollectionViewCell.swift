//
//  RecommendCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit

final class RecommendCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let recommendText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(recommendText)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(28)
        }
        
        recommendText.snp.makeConstraints { make in
            make.verticalEdges.equalTo(backView)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(backView.snp.leading).offset(-4)
        }
        
    }
    
    override func configureUI() {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 14
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func designCell(transition: String) {
        
        recommendText.text = transition
        
    }
    
}
