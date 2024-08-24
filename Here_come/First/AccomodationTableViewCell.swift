//
//  AccomodationCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/15/24.
//

import UIKit
import SnapKit
import RxSwift

final class AccomodationTableViewCell: BaseTableViewCell {
    
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
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
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
        
        commentButton.snp.makeConstraints { make in
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
            make.bottom.equalTo(likeImage.snp.top).offset(-20)
        }
        
    }
    
    override func configureUI() {
        
        selectionStyle = .none
        
        profileImage.image = UIImage(named: "profile_10")
        profileImage.layer.masksToBounds = true
        
        userName.font = .systemFont(ofSize: 13)
        
        locationLabel.font = .systemFont(ofSize: 13)
        
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        
        likeImage.image = UIImage(systemName: "heart")
        likeImage.tintColor = .black
        
        commentImage.image = UIImage(systemName: "bubble.right")
        commentImage.tintColor = .black
        
        locationImage.image = UIImage(systemName: "map")
        locationImage.tintColor = .black
        
    }
    
    func designCell(transition: Posts) {
        
        let nicklocation = ExtractSentence.shared.splitString(transition.creator.nick)
        
        userName.text = nicklocation[0]
     
        locationLabel.text = nicklocation[1] + " " + nicklocation[2]
        
        descriptionLabel.text = transition.content1
        
        likeCount.text = "\(transition.likes.count)"
        
        commentCount.text = "\(transition.comments!.count)"
        
        likeImage.image = UserDefaults.standard.bool(forKey: transition.post_id) ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        
        likeImage.tintColor = .black
        
    }
    
}

extension AccomodationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
}

extension AccomodationTableViewCell: UICollectionViewDelegateFlowLayout {
    private func imageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: contentView.bounds.width, height: 260)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
}
