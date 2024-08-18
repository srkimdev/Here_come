//
//  PhotoCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/18/24.
//

import UIKit
import SnapKit

final class PhotoCollectionViewCell: BaseCollectionViewCell {
    
    let photoImage = UIImageView()
    let deleteButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 13)
        let image = UIImage(systemName: "xmark", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        deleteButton.layer.cornerRadius = deleteButton.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImage)
        contentView.addSubview(deleteButton)
    }
    
    override func configureLayout() {
        photoImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(70)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(4)
            make.size.equalTo(20)
        }
    }
    
    override func configureUI() {
        photoImage.layer.masksToBounds = true
        photoImage.layer.cornerRadius = 5
        photoImage.backgroundColor = .red
        
        deleteButton.backgroundColor = .black
        deleteButton.tintColor = .white
    }
    
    func designCell(transition: String) {
        
        
        
    }
    
}
