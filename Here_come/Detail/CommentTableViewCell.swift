//
//  CommentTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/22/24.
//

import UIKit
import SnapKit

final class CommentTableViewCell: BaseTableViewCell {
    
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
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.size.equalTo(30)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
        }
        
        profileImage.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
        }
        
    }
    
    override func configureUI() {
        
        profileImage.image = UIImage(named: "profile_10")
        
        userName.text = "야옹"
        userName.font = .systemFont(ofSize: 14)
        
        locationLabel.text = "제주시 월정리"
        locationLabel.font = .systemFont(ofSize: 14)
        
    }
    
    func designCell(transition: String) {
        commentLabel.text = transition
    }
    
}
