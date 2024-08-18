//
//  WriteViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/18/24.
//

import Foundation
import RxSwift
import RxCocoa

final class WriteViewModel {
    
    let image = ["", "", "", "", "", "", "", ""]
    
    struct Input {
        let categoryButtonTap: ControlEvent<Void>
        let imageButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let categoryButtonTap: ControlEvent<Void>
        let imageButtonTap: ControlEvent<Void>
        let photoCollectionView: PublishSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        let photoCollectionView = PublishSubject<[String]>()
        
        photoCollectionView.onNext(image)
        
        return Output(categoryButtonTap: input.categoryButtonTap, imageButtonTap: input.imageButtonTap, photoCollectionView: photoCollectionView)
    }
    
}
