//
//  RecentTextCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit

final class RecentTextCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let recentText = UILabel()
    let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(recentText)
        backView.addSubview(deleteButton)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(28)
        }
        
        recentText.snp.makeConstraints { make in
            make.verticalEdges.equalTo(backView)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-4)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(backView)
            make.trailing.equalTo(backView.snp.trailing).inset(10)
            make.size.equalTo(10)
        }
        
    }
    
    override func configureUI() {
        
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 14
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.lightGray.cgColor
        
        recentText.font = .systemFont(ofSize: 15)
        
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        
    }
    
    func designCell(transition: String) {
        recentText.text = transition
    }
    
}
