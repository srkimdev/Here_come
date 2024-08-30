//
//  DetailHouseViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/27/24.
//

import UIKit
import RxSwift
import RxCocoa
import iamport_ios

final class DetailHouseViewModel {
    
    let disposeBag = DisposeBag()
    let idInfo = BehaviorRelay<[String]>(value: [])
    
    struct Input {
        let networkTrigger: BehaviorRelay<House?>
    }
    
    struct Output {
        let imageArray: BehaviorSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        let imageArray = BehaviorSubject<[String]>(value: [])
        
        input.networkTrigger
            .bind(with: self) { owner, value in
                imageArray.onNext(value?.image ?? [])
            }
            .disposed(by: disposeBag)
        
        return Output(imageArray: imageArray)
    }
    
}
