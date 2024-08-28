//
//  AccomodationCollectionViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/15/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

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
    let pageControl = UIPageControl()
    
    let updateImage = BehaviorRelay<[String]>(value: [])
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        setupPageControl()
        
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
        contentView.addSubview(pageControl)
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
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(imageCollectionView.snp.bottom).inset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        likeImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(24)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(24)
        }
        
        likeCount.snp.makeConstraints { make in
            make.centerY.equalTo(likeImage)
            make.leading.equalTo(likeImage.snp.trailing).offset(4)
            make.height.equalTo(24)
            make.width.equalTo(10)
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
            make.width.equalTo(10)
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
        
        commentImage.image = UIImage(systemName: "bubble.right")
        commentImage.tintColor = .black
        
        locationImage.image = UIImage(systemName: "map")
        locationImage.tintColor = .black
        
        imageCollectionView.showsHorizontalScrollIndicator = false
        
        pageControl.backgroundColor = .black
    }
    
    func designCell(transition: Posts) {
        
        let nicklocation = ExtractSentence.shared.splitString(transition.creator.nick)
        
        userName.text = nicklocation[0]
     
        locationLabel.text = nicklocation[1] + " " + nicklocation[2]
        
        descriptionLabel.text = transition.content1
        
        likeCount.text = "\(transition.likes.count)"
        
        commentCount.text = "\(transition.comments!.count)"
        
        likeImage.image = UserDefaults.standard.bool(forKey: transition.post_id) ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
        likeImage.tintColor = UserDefaults.standard.bool(forKey: transition.post_id) ? .black : .red
        
        updateImage.accept(transition.files ?? [])
        bind()
        
    }
    
    func bind() {
        
        updateImage
            .observe(on: MainScheduler.instance)
            .bind(to: imageCollectionView.rx.items(cellIdentifier: ImageCollectionViewCell.identifier, cellType: ImageCollectionViewCell.self)) { (item, element, cell) in

                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        imageCollectionView.rx.contentOffset
            .map { [weak self] contentOffset in
                guard let self = self else { return 0 }
                
                let width = self.imageCollectionView.frame.width
                guard width > 0 else { return 0 }
                
                let pageIndex = round(contentOffset.x / width)
                return Int(pageIndex)
            }
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)
        
    }
    
    private func setupPageControl() {
        
        pageControl.numberOfPages = updateImage.value.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .lightGray
        
    }
    
}

extension AccomodationTableViewCell: UICollectionViewDelegateFlowLayout {
    private func imageCollectionViewLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        
        return layout
    }
}
