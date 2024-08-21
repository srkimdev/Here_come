//
//  DetailViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/21/24.
//

import UIKit
import SnapKit
import RxSwift

final class DetailViewController: BaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let categoryBackView = UIView()
    let categoryLabel = UILabel()
    
    let profileImage = UIImageView()
    let userName = UILabel()
    let locationLabel = UILabel()
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
    
    let seperateLine = UIView()
    
    let disposeBag = DisposeBag()
    let viewModel = DetailViewModel()
    var data: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        categoryBackView.layer.cornerRadius = categoryBackView.frame.width / 2
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(categoryBackView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(profileImage)
        contentView.addSubview(userName)
        contentView.addSubview(locationLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(seperateLine)
        
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        categoryBackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(categoryBackView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.size.equalTo(40)
        }
        
        userName.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.leading.equalTo(profileImage.snp.trailing).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(10)
        }
        
    }
    
    override func configureUI() {
        
        guard let data else { return }
        
        categoryBackView.backgroundColor = .systemGray5
        categoryBackView.layer.masksToBounds = true
        
        profileImage.layer.masksToBounds = true
        profileImage.image = UIImage(named: "profile_10")
        
        userName.text = "말챠"
        userName.font = .systemFont(ofSize: 15, weight: .bold)
        
        locationLabel.text = "제주시 애월읍"
        locationLabel.font = .systemFont(ofSize: 15)
        
        titleLabel.text = data.title
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        
        contentLabel.text = data.content
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        
        seperateLine.backgroundColor = .systemGray5
        
    }
    
    func bind() {
        
        let output = viewModel.transform()
        
        output.imageList
            .bind(to: imageCollectionView.rx.items(cellIdentifier: DetailCollectionViewCell.identifier, cellType: DetailCollectionViewCell.self)) { (item, element, cell) in
                
                print(element)
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func imageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width - 32
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .vertical
        return layout
    }
}
