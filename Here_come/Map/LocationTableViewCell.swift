//
//  LocationTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/28/24.
//

import UIKit
import SnapKit

final class LocationTableViewCell: BaseTableViewCell {
    
    let addressLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    override func configureHierarchy() {
        contentView.addSubview(addressLabel)
    }
    
    override func configureLayout() {
        addressLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
    }
    
    override func configureUI() {
        
    }
    
    func designCell(transition: String) {
        addressLabel.text = transition
    }
    
}
