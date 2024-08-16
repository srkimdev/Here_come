//
//  AccomodationCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/15/24.
//

import UIKit
import SnapKit

final class AccomodationCollectionViewCell: BaseCollectionViewCell {
    
    let profileImage = UIImageView()
    let userName = UILabel()
    let locationLabel = UILabel()
    let likeImage = UIImageView()
    let likeButton = UIButton()
    let likeCount = UILabel()
    let commentImage = UIImageView()
    let commentButton = UIButton()
    let commentCount = UILabel()
    let locationImage = UIImageView()
    let locationButton = UIButton()
    let descriptionLabel = UILabel()
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        contentView.backgroundColor = .lightGray
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(userName)
        contentView.addSubview(locationLabel)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(likeImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeCount)
        contentView.addSubview(commentImage)
        contentView.addSubview(commentButton)
        contentView.addSubview(commentCount)
        contentView.addSubview(locationImage)
        contentView.addSubview(locationButton)
        contentView.addSubview(locationLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.size.equalTo(40)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top).offset(4)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(260)
        }
        
        likeImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(24)
        }
        
        likeCount.snp.makeConstraints { make in
            make.centerY.equalTo(likeImage)
            make.leading.equalTo(likeImage.snp.trailing).offset(4)
            make.height.equalTo(24)
        }
        
        commentImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(likeCount.snp.trailing).offset(12)
            make.size.equalTo(24)
        }
        
        commentCount.snp.makeConstraints { make in
            make.centerY.equalTo(likeImage)
            make.leading.equalTo(commentImage.snp.trailing).offset(4)
            make.height.equalTo(24)
        }
        
        locationImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(commentCount.snp.trailing).offset(12)
            make.size.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(likeImage.snp.top).offset(-12)
        }
        
    }
    
    override func configureUI() {
        profileImage.image = UIImage(named: "profile_10") //
        profileImage.layer.masksToBounds = true
        
        userName.text = "Carribean"
        userName.font = .systemFont(ofSize: 13)
        
        locationLabel.text = "제주시 월정리"
        locationLabel.font = .systemFont(ofSize: 13)
        
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "결국 혼자 다녀오게 되었지만.. 컨디션 유지 위해 한번 쉰 것 외에는 쉼 없이 걸었는데 ... 의미가 담긴 에 완주 해싸. 뮤지컬 영웅 를 들으면 앞만 보거나 한강 풍경 보면서 걸었다. 그리고 나에게 집중하는 시간을 가졌다. 매우 만족 어린 자녀들과 함께 와주신 부모님들이 많았는데 참 보기 좋았던 것 같다. 완보 메달도 태극기 모양이라 다른 대회와 색달라서 꼭 소유하고 싶었는데 잘 취득"
        
        likeImage.image = UIImage(systemName: "heart")
        likeImage.tintColor = .black
        likeCount.text = "10"
        
        commentImage.image = UIImage(systemName: "bubble.right")
        commentImage.tintColor = .black
        commentCount.text = "1"
        
        locationImage.image = UIImage(systemName: "map")
        locationImage.tintColor = .black
    }
    
}

extension AccomodationCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}

extension AccomodationCollectionViewCell: UICollectionViewDelegateFlowLayout {
    private func imageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: contentView.bounds.width, height: 260)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
}
