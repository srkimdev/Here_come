//
//  ImageCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class ImageCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
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
        let url = URL(string: APIKey.baseURL + "v1/" + transition)!
        imageView.kf.setImage(with: url, options: [.requestModifier(KingfisherManager.shared.modifier)])
    }
    
}
