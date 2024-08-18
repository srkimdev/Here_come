//
//  ProfileManageViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit

final class ProfileManageViewController: BaseViewController {
    
    let profileButton = UIButton()
    let profileImage = UIImageView()
    let userName = UILabel()
    let locationLabel = UILabel()
    
    let settingTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        view.addSubview(profileButton)
        view.addSubview(profileImage)
        view.addSubview(userName)
        view.addSubview(locationLabel)
        view.addSubview(settingTableView)
    }
    
    override func configureLayout() {
        
        profileButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(74)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.top).offset(12)
            make.leading.equalTo(profileButton.snp.leading).offset(16)
            make.size.equalTo(50)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(2)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
            make.height.equalTo(20)
        }
        
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        navigationItem.title = "내 정보"
        
        profileButton.layer.borderColor = UIColor.systemGray5.cgColor
        profileButton.layer.borderWidth = 1
        
        profileImage.layer.masksToBounds = true
        profileImage.backgroundColor = .red
        
        userName.text = "Carribean"
        
        settingTableView.backgroundColor = .lightGray
        settingTableView.rowHeight = 60
        
    }
    
}

extension ProfileManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        
        return cell
    }
}
