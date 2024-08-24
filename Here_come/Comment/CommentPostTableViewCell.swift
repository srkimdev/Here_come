//
//  CommentPostTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/24/24.
//

import UIKit
import SnapKit

final class CommentPostTableViewCell: BaseTableViewCell {
    
    let profileImage = UIImageView()
    let userName = UILabel()
    let locationLabel = UILabel()
    let commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(userName)
        contentView.addSubview(locationLabel)
        contentView.addSubview(commentLabel)
    }
    
    override func configureLayout() {
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(36)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(16)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
    }
    
    override func configureUI() {
        
        profileImage.image = UIImage(named: "profile_10")
        
        userName.font = .systemFont(ofSize: 14)
        
        locationLabel.font = .systemFont(ofSize: 14)
        
        commentLabel.numberOfLines = 0
        
    }
    
    func designCell(transition: Comment) {
        
        let nicklocation = ExtractSentence.shared.splitString(transition.creator.nick)
        
        userName.text = nicklocation[0]
        
        locationLabel.text = nicklocation[1] + " " + nicklocation[2]
        
        commentLabel.text = transition.content
    }
    
}
