//
//  StarStackView.swift
//  Here_come
//
//  Created by 김성률 on 8/26/24.
//

import UIKit
import SnapKit

class StarRatingView: UIView {
    
    private let starStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        starStackView.axis = .horizontal
        starStackView.distribution = .fillEqually
        starStackView.spacing = 0
        
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.image = UIImage(systemName: "star.fill")
            starImageView.tintColor = .init(hex: "#FFE802")
            starImageView.contentMode = .scaleAspectFill
            starStackView.addArrangedSubview(starImageView)
        }
        
        addSubview(starStackView)
    }
    
    private func setupConstraints() {
        starStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
