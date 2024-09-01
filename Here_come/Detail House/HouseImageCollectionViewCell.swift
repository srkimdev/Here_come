//
//  HouseImageCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/27/24.
//

import UIKit
import SnapKit

final class HouseImageCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        imageView.contentMode = .scaleAspectFill
    }
    
    func designCell(transition: String) {
        imageView.image = UIImage(named: transition)
    }
    
}

