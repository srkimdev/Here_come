//
//  SociallingTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit
import RxSwift

final class SociallingTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    lazy var sociallingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: sociallingCollectionViewLauout())
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func sociallingCollectionViewLauout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: contentView.bounds.width - 28, height: 100)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sociallingCollectionView.register(SociallingCollectionViewCell.self, forCellWithReuseIdentifier: SociallingCollectionViewCell.identifier)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(sociallingCollectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
        }
        
        sociallingCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    override func configureUI() {
        
    }
    
    func designCell(transition: String) {
        print("draw")
        titleLabel.text = transition
    }
    
}


// 추천 소셜링, 인기 소셜링, NEW
