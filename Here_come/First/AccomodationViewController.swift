//
//  AccomodationViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import UIKit
import SnapKit
import RxSwift

final class AccomodationViewController: BaseViewController {
    
    lazy var postCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(AccomodationCollectionViewCell.self, forCellWithReuseIdentifier: AccomodationCollectionViewCell.identifier)
        
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(postCollectionView)
    }
    
    override func configureLayout() {
        postCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        
    }
    
    func bind() {
        
    }
    
}

extension AccomodationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: AccomodationCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
}

extension AccomodationViewController: UICollectionViewDelegateFlowLayout {
    private func postCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: 500)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
}


