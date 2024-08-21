//
//  DetailViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/21/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    
    let disposeBag = DisposeBag()
    var transitionData = BehaviorRelay<[String]>(value: [])
    
    struct Input {
        
    }
    
    struct Output {
        let imageList: BehaviorSubject<[String]>
    }
    
    func transform() -> Output {
        
        let imageList = BehaviorSubject<[String]>(value: [])
        
        transitionData
            .bind(with: self) { owner, value in
                imageList.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(imageList: imageList)
    }
    
}
