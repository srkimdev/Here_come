//
//  WriteReviewViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/23/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import PhotosUI

final class WriteReviewViewController: BaseViewController {
    
    let locationButton = UIButton()
    let locationImage = UIImageView()
    let locationLabel = UILabel()
    let nextImage = UIImageView()
    
    let addImagebutton = UIButton()
    let cameraImage = UIImageView()
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
    
    let seperateLine = UIView()
    let contentTextView = UITextView()
    
    let viewModel = WriteReviewViewModel()
    let disposeBag = DisposeBag()
    let pickerSubject = BehaviorRelay<[UIImage]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.register(WriteReviewCollectionViewCell.self, forCellWithReuseIdentifier: WriteReviewCollectionViewCell.identifier)
        
        bind()
        
    }
    
    override func configureHierarchy() {
        view.addSubview(locationButton)
        locationButton.addSubview(locationImage)
        locationButton.addSubview(locationLabel)
        locationButton.addSubview(nextImage)
        view.addSubview(addImagebutton)
        addImagebutton.addSubview(cameraImage)
        view.addSubview(imageCollectionView)
        view.addSubview(seperateLine)
        view.addSubview(contentTextView)
    }
    
    override func configureLayout() {
        
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        locationImage.snp.makeConstraints { make in
            make.centerY.equalTo(locationButton)
            make.leading.equalTo(locationButton.snp.leading).offset(12)
            make.size.equalTo(40)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationButton)
            make.leading.equalTo(locationImage.snp.trailing).offset(8)
        }
        
        nextImage.snp.makeConstraints { make in
            make.centerY.equalTo(locationButton)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        addImagebutton.snp.makeConstraints { make in
            make.top.equalTo(locationButton.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(70)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.center.equalTo(addImagebutton)
            make.size.equalTo(30)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(locationButton.snp.bottom)
            make.leading.equalTo(addImagebutton.snp.trailing).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(110)
        }
        
        seperateLine.snp.makeConstraints { make in
            make.top.equalTo(addImagebutton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        
        locationButton.layer.borderWidth = 1
        locationButton.layer.borderColor = UIColor.systemGray4.cgColor
        
        locationImage.image = UIImage(named: "location")
        
        locationLabel.text = "장소"
        
        nextImage.image = UIImage(systemName: "chevron.right")
        nextImage.tintColor = .black
        
        addImagebutton.layer.masksToBounds = true
        addImagebutton.layer.cornerRadius = 5
        addImagebutton.layer.borderWidth = 1
        addImagebutton.layer.borderColor = UIColor.systemGray4.cgColor
        
        cameraImage.image = UIImage(systemName: "photo.badge.plus")
        cameraImage.tintColor = .systemGray4
        
        seperateLine.backgroundColor = .systemGray4
        
        contentTextView.text = "숙소, 생활 관련 후기를 작성해주세요"
        contentTextView.textColor = .lightGray
        contentTextView.font = .systemFont(ofSize: 15)
        
    }
    
    func bind() {
        
        let input = WriteReviewViewModel.Input(addButtonTap: addImagebutton.rx.tap, pickerSubject: pickerSubject)
        let output = viewModel.transform(input: input)
        
        
        output.addButtonTap
            .bind(with: self) { owner, _ in
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 5
                configuration.filter = .any(of: [.screenshots, .images])
                
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                
                owner.present(picker, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.imageCollectionView
            .bind(to: imageCollectionView.rx.items(cellIdentifier: WriteReviewCollectionViewCell.identifier, cellType: WriteReviewCollectionViewCell.self)) {
                (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
        
        
    }
    
}

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
    func imageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension WriteReviewViewController: PHPickerViewControllerDelegate {
    
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
