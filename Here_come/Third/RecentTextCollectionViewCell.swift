//
//  RecentTextCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit
import RxSwift

final class RecentTextCollectionViewCell: BaseCollectionViewCell {
    
    let recentText = UILabel()
    let deleteButton = UIButton()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(recentText)
        contentView.addSubview(deleteButton)
    }
    
    override func configureLayout() {

        
        recentText.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-24)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.size.equalTo(10)
        }
        
    }
    
    override func configureUI() {
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 14
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        recentText.font = .systemFont(ofSize: 15)
        recentText.numberOfLines = 1
        
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
    }
    
    func designCell(transition: String) {
        recentText.text = transition
//        recentText.sizeToFit()
    }
    
}
