//
//  CategoryTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import UIKit
import SnapKit

final class CategoryTableViewCell: BaseTableViewCell {
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureUI() {
        
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func categoryCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 20, height: 40)
        layout.minimumLineSpacing = 10
        return layout
    }
}
