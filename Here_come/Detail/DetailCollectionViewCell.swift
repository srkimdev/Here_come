//
//  DetailCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/21/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let myImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(myImage)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        myImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    override func configureUI() {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 5
        
        myImage.contentMode = .scaleAspectFit
    }
    
    func designCell(transition: String) {
        
        let url = URL(string: APIKey.baseURL + "v1/" + transition)
        myImage.kf.setImage(with: url, options: [.requestModifier(KingfisherManager.shared.modifier)])
        
    }

}
