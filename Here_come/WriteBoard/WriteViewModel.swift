//
//  WriteViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/18/24.
//

import UIKit
import RxSwift
import RxCocoa

final class WriteViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let categoryButtonTap: ControlEvent<Void>
        let imageButtonTap: ControlEvent<Void>
        let pickerSubject: BehaviorRelay<[UIImage]>
    }
    
    struct Output {
        let categoryButtonTap: ControlEvent<Void>
        let imageButtonTap: ControlEvent<Void>
        let photoCollectionView: PublishSubject<[UIImage]>
    }
    
    func transform(input: Input) -> Output {
        
        let photoCollectionView = PublishSubject<[UIImage]>()
    
        input.pickerSubject
            .bind(with: self) { owner, value in
                photoCollectionView.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(categoryButtonTap: input.categoryButtonTap, imageButtonTap: input.imageButtonTap, photoCollectionView: photoCollectionView)
    }
    
}
