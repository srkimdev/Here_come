//
//  WriteViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/17/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import PhotosUI

final class WriteViewController: BaseViewController {
    
    let categoryLabel = UILabel()
    let nextImage = UIImageView()
    let categoryButton = UIButton()
    
    let titleTextField = UITextField()
    let contentTextView = UITextView()
    
    lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionViewLayout())
    let imageButton = UIButton()
    
    let pickerSubject = BehaviorRelay<[UIImage]>(value: [])
    let viewModel = WriteViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        bindNavi()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        imageButton.layer.cornerRadius = imageButton.frame.width / 2
    }
    
    override func configureHierarchy() {
        view.addSubview(categoryButton)
        categoryButton.addSubview(categoryLabel)
        categoryButton.addSubview(nextImage)
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)
        view.addSubview(photoCollectionView)
        view.addSubview(imageButton)
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
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(contentTextView.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(90)
        }
        
        imageButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(40)
        }
        
    }
    
    override func configureUI() {
        navigationItem.title = "글쓰기"
        
        categoryLabel.text = "서핑"
        
        categoryButton.layer.borderWidth = 1
        categoryButton.layer.borderColor = UIColor.systemGray5.cgColor
        
        nextImage.image = UIImage(systemName: "chevron.right")
        nextImage.tintColor = .black
        
        titleTextField.placeholder = "제목을 입력하세요"
        titleTextField.font = .systemFont(ofSize: 20, weight: .bold)
        
        contentTextView.text = "환영합니다"
        contentTextView.textColor = .lightGray
        contentTextView.font = .systemFont(ofSize: 15)
        
        imageButton.backgroundColor = .lightGray
        imageButton.layer.masksToBounds = true
        imageButton.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func bindNavi() {
        
        let item = UIBarButtonItem(title: "완료", style: .plain, target: self, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        item.rx.tap
            .bind(with: self) { owner, _ in
                
                NetworkManager.shared.uploadImage(images: owner.pickerSubject.value) { value in
                    
                    let postQuery = PostQuery(title: owner.titleTextField.text!, content: "#" + owner.categoryLabel.text!, content1: self.contentTextView.text!, product_id: "herecome", files: value)
                    
                    NetworkManager.shared.uploadPost(query: postQuery) { value in
                        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
                        owner.navigationController?.popViewController(animated: true)
                    }
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
    func bind() {
        
        let input = WriteViewModel.Input(categoryButtonTap: categoryButton.rx.tap, imageButtonTap: imageButton.rx.tap, pickerSubject: pickerSubject)
        let output = viewModel.transform(input: input)
        
        output.categoryButtonTap
            .bind(with: self) { owner, _ in
                
                let vc = CategoryViewController()
                vc.viewModel.selectedValue.accept(owner.categoryLabel.text ?? "")
                
                vc.categoryClosure = { value in
                    owner.categoryLabel.text = value
                }
                
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.large()]
                    sheet.prefersGrabberVisible = true
                }
                
                owner.present(vc, animated: true)
                
            }
            .disposed(by: disposeBag)
        
        output.imageButtonTap
            .bind(with: self) { owner, _ in
                
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 5
                configuration.filter = .any(of: [.screenshots, .images])
                
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                
                owner.present(picker, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.photoCollectionView
            .bind(to: photoCollectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier, cellType: PhotoCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
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

extension WriteViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        var selectedImage: [UIImage] = []
        let dispatchGroup = DispatchGroup()
        
        for result in results {
            dispatchGroup.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage {
                    selectedImage.append(image)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.pickerSubject.accept(selectedImage)
        }
        
    }
}

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "숙소, 생활 관련 후기를 작성해주세요"
            textView.textColor = .lightGray
        }
        
    }
    
}



