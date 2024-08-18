//
//  WriteViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/17/24.
//

import UIKit
import SnapKit
import RxSwift

final class WriteViewController: BaseViewController {
    
    let categoryLabel = UILabel()
    let nextImage = UIImageView()
    let categoryButton = UIButton()
    
    let titleTextField = UITextField()
    let contentTextView = UITextView()
    
    let photoLabel = UILabel()
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionViewLayout())
    
    let viewModel = WriteViewModel()
    let disposeBag = DisposeBag()
    
    let image = ["", "", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(categoryButton)
        categoryButton.addSubview(categoryLabel)
        categoryButton.addSubview(nextImage)
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        view.addSubview(photoLabel)
        view.addSubview(photoCollectionView)
    }
    
    override func configureLayout() {
        
        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButton)
            make.leading.equalTo(categoryButton.snp.leading).offset(16)
        }
        
        nextImage.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButton)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(300)
        }
        
        photoLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(20)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photoLabel.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(90)
        }
        
    }
    
    override func configureUI() {
        navigationItem.title = "글쓰기"
        
        let item = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = item
        
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.systemGray5.cgColor
        
        categoryLabel.text = "맛집"
        
        nextImage.image = UIImage(systemName: "chevron.right")
        nextImage.tintColor = .black
        
        titleTextField.placeholder = "제목을 입력하세요"
        titleTextField.font = .systemFont(ofSize: 20, weight: .bold)
        
        contentTextView.text = "환영합니다"
        contentTextView.textColor = .lightGray
        contentTextView.font = .systemFont(ofSize: 15)
        
        photoLabel.text = "사진을 등록해주세요"
        
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    func bind() {
        
        let input = WriteViewModel.Input(categoryButtonTap: categoryButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.categoryButtonTap
            .bind(with: self) { owner, _ in
                print("tap")
            }
            .disposed(by: disposeBag)
        
//        output.photoCollectionView
//            .bind(to: photoCollectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier, cellType: PhotoCollectionViewCell.self)) { (item, element, cell) in
//                
//                cell.designCell(transition: self.image[item])
//                
//            }
//            .disposed(by: disposeBag)
        
    }
    
}

extension WriteViewController: UICollectionViewDelegateFlowLayout {
    func photoCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
}




