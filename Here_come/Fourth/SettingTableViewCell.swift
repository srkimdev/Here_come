//
//  SettingTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/18/24.
//

import UIKit
import SnapKit

final class SettingTableViewCell: BaseTableViewCell {
    
    let iconImage = UIImageView()
    let settingName = UILabel()
    let nextButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(iconImage)
        contentView.addSubview(settingName)
        contentView.addSubview(nextButton)
    }
    
    override func configureLayout() {
        iconImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        settingName.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(iconImage.snp.trailing).offset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
    override func configureUI() {
        
        iconImage.image = UIImage(systemName: "star")
        
        settingName.text = "공지사항"
        
        nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        
    }
    
}
