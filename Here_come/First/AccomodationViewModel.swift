//
//  AccomodationViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/15/24.
//

import Foundation
import RxSwift

final class AccomodationViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let networkTrigger: Observable<Void>
        let pullToRefresh: PublishSubject<Void>
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[Posts]>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[Posts]>(value: [])
        
        input.networkTrigger
            .bind(with: self) { owner, _ in
                NetworkManager.shared.readPost(productId: "herecomePost") { value in
                    tableViewList.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        input.pullToRefresh
            .bind(with: self) { owner, _ in
                NetworkManager.shared.readPost(productId: "herecomePost") { value in
                    tableViewList.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(tableViewList: tableViewList)
    }
    
}
