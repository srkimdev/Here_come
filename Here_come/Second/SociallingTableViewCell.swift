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
        contentView.addSubview(categoryLabel)
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
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
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
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.trailing.equalTo(likeCount.snp.leading).offset(-2)
            make.size.equalTo(16)
        }
        
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.trailing.equalTo(commentImage.snp.leading).offset(-4)
            make.height.equalTo(16)
        }
        
        commentImage.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.trailing.equalTo(commentCount.snp.leading).offset(-2)
            make.size.equalTo(16)
        }
        
        commentCount.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(4)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(16)
        }
        
    }
    
    override func configureUI() {
        categoryLabel.text = "여름휴가"
        categoryLabel.backgroundColor = .systemGray6
        
        titleLabel.text = "여름휴가 후기를 들려주세요!"
        
        contentLabel.text = "4명정도 작게 모여서 저녁 조금 늦게 야식 드실분 신림쪽에서 모이고, 모각코 일정은 주 ㅣ1회 대면"
        contentLabel.font = .systemFont(ofSize: 13)
        
        locationLabel.text = "제주시 애월읍"
        locationLabel.font = .systemFont(ofSize: 13)
        
        optionalImage.layer.masksToBounds = true
        optionalImage.layer.cornerRadius = 5
        
        likeImage.image = UIImage(systemName: "heart")
        likeImage.tintColor = .black

        likeCount.text = "3"
        likeCount.font = .systemFont(ofSize: 13)
        
        commentImage.image = UIImage(systemName: "bubble.right")
        commentImage.tintColor = .black
        
        commentCount.text = "3"
        commentCount.font = .systemFont(ofSize: 13)
    }
    
    func designCell(transition: Posts) {
        
        titleLabel.text = transition.title
        
        contentLabel.text = transition.content
        
        let url = URL(string: "http://lslp.sesac.co.kr:24513/v1/" + (transition.files?[0] ?? ""))
        optionalImage.kf.setImage(with: url, options: [.requestModifier(KingfisherManager.shared.modifier)])
        
    }
    
}

