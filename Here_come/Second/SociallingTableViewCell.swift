//
//  SociallingTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class SociallingTableViewCell: BaseTableViewCell {
    
    let categoryView = UIView()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let locationLabel = UILabel()
    
    let optionalImage = UIImageView()
    let likeImage = UIImageView()
    let likeCount = UILabel()
    let commentImage = UIImageView()
    let commentCount = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(categoryView)
        categoryView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(likeImage)
        contentView.addSubview(commentImage)
        contentView.addSubview(optionalImage)
        contentView.addSubview(likeImage)
        contentView.addSubview(likeCount)
        contentView.addSubview(commentImage)
        contentView.addSubview(commentCount)
    }
    
    override func configureLayout() {
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(categoryView).inset(4)
            make.centerY.equalTo(categoryView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(optionalImage.snp.leading).offset(-4)
            make.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(optionalImage.snp.leading).offset(-4)
            make.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
        }
        
        optionalImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(70)
        }
        
        likeImage.snp.makeConstraints { make in
            make.bottom.equalTo(locationLabel.snp.bottom)
            make.trailing.equalTo(likeCount.snp.leading).offset(-2)
            make.size.equalTo(16)
        }
        
        likeCount.snp.makeConstraints { make in
            make.bottom.equalTo(locationLabel.snp.bottom)
            make.trailing.equalTo(commentImage.snp.leading).offset(-4)
            make.height.equalTo(16)
        }
        
        commentImage.snp.makeConstraints { make in
            make.bottom.equalTo(locationLabel.snp.bottom)
            make.trailing.equalTo(commentCount.snp.leading).offset(-2)
            make.size.equalTo(16)
        }
        
        commentCount.snp.makeConstraints { make in
            make.bottom.equalTo(locationLabel.snp.bottom)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(16)
        }
        
    }
    
    override func configureUI() {
        
        categoryView.layer.masksToBounds = true
        categoryView.layer.cornerRadius = 2
        categoryView.backgroundColor = .systemGray5
        
        categoryLabel.text = "여름휴가"
        categoryLabel.font = .systemFont(ofSize: 13)
        
        contentLabel.font = .systemFont(ofSize: 13)
        
        locationLabel.text = "제주시 애월읍"
        locationLabel.font = .systemFont(ofSize: 13)
        
        optionalImage.layer.masksToBounds = true
        optionalImage.layer.cornerRadius = 5
        
        likeImage.image = UIImage(systemName: "heart")
        likeImage.tintColor = .black

        likeCount.font = .systemFont(ofSize: 13)
        
        commentImage.image = UIImage(systemName: "bubble.right")
        commentImage.tintColor = .black
        
        commentCount.font = .systemFont(ofSize: 13)
    }
    
    func designCell(transition: Posts) {
        
        categoryLabel.text = transition.content
        
        titleLabel.text = transition.title

        contentLabel.text = transition.content1
        
        let url = URL(string: APIKey.baseURL + "v1/" + (transition.files?[0] ?? ""))!
        optionalImage.kf.setImage(with: url, options: [.requestModifier(KingfisherManager.shared.modifier)])
        
        likeCount.text = "\(transition.likes.count)"
        
        commentCount.text = "\(transition.comments!.count )"
        
    }
    
}

