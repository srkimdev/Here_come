//
//  DetailHouseViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/27/24.
//

import UIKit
import RxSwift

final class DetailHouseViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let networkTrigger: BehaviorSubject<House?>
    }
    
    struct Output {
        let imageArray: BehaviorSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        let imageArray = BehaviorSubject<[String]>(value: [])
        
        input.networkTrigger
            .bind(with: self) { owner, value in
                print(value, "networktrigger")
                imageArray.onNext(value?.image ?? [])
            }
            .disposed(by: disposeBag)
        
        return Output(imageArray: imageArray)
    }
    
}
