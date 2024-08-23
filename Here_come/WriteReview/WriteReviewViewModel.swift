//
//  WriteReviewViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/23/24.
//

import UIKit
import RxSwift
import RxCocoa

final class WriteReviewViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let addButtonTap: ControlEvent<Void>
        let pickerSubject: BehaviorRelay<[UIImage]>
    }
    
    struct Output {
        let addButtonTap: ControlEvent<Void>
        let imageCollectionView: PublishSubject<[UIImage]>
    }
    
    func transform(input: Input) -> Output {
        
        let imageCollectionView = PublishSubject<[UIImage]>()
        
        input.pickerSubject
            .bind(with: self) { owner, value in
                imageCollectionView.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(addButtonTap: input.addButtonTap, imageCollectionView: imageCollectionView)
    }
    
}
