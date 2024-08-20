//
//  CategoryTableViewCell.swift
//  Here_come
//
//  Created by 김성률 on 8/19/24.
//

import UIKit
import SnapKit
import RxSwift

final class CategoryTableViewCell: BaseTableViewCell {
    
    let title: [String] = ["액티비티", "실내", "구인/구직"]
    
    let categoryLabel = UILabel()
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoryCollectionViewLayout())
    
    var disposeBag = DisposeBag()
    var list:[String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryCollectionView)
    }
    
    override func configureLayout() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(20)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        categoryLabel.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    func designCell(transition: [String], selectedValue: String, row: Int) {
        
        categoryLabel.text = title[row]
        list = transition
        
        Observable.just(transition)
            .bind(to: categoryCollectionView.rx.items(cellIdentifier: CategoryCollectionViewCell.identifier, cellType: CategoryCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element, selectedValue: selectedValue)
                
            }
            .disposed(by: disposeBag)
        
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func categoryCollectionViewLayout() -> UICollectionViewLayout {
        let layout = CustomCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        return layout
    }
    
    // self-sizing cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let text = list[indexPath.item]
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 36)
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16)]
        let textSize = (text as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size

        return CGSize(width: textSize.width + 30, height: 36)
    }
    
    class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
        
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let attributes = super.layoutAttributesForElements(in: rect) else {
                return nil
            }

            var leftMargin = sectionInset.left
            var maxY: CGFloat = -1.0
            
            for attribute in attributes {
                if attribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                attribute.frame.origin.x = leftMargin
                leftMargin += attribute.frame.width + minimumInteritemSpacing
                
                maxY = max(attribute.frame.maxY , maxY)
            }
            
            return attributes
        }
    }
    
}

