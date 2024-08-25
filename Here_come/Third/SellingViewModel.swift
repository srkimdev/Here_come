//
//  SellingViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/25/24.
//

import Foundation
import RxSwift

final class SellingViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let networkTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let updateTableView: BehaviorSubject<[House]>
    }
    
    func transform(input: Input) -> Output {
        
        let updateTableView = BehaviorSubject<[House]>(value: [])
        
        input.networkTrigger
            .bind(with: self) { owner, _ in
                updateTableView.onNext(houses)
            }
            .disposed(by: disposeBag)
        
        return Output(updateTableView: updateTableView)
    }
    
}
