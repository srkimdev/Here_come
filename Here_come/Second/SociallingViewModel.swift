//
//  SociallingViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/16/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SociallingViewModel {
    
    let disposeBag = DisposeBag()
    var selectedValue = BehaviorRelay<String>(value: "전체")
    
    struct Input {
        let networkTrigger: Observable<Void>
        let pullToRefresh: PublishSubject<Void>
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[Posts]>
        let collectionViewList: BehaviorSubject<[Category]>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[Posts]>(value: [])
        let collectionViewList = BehaviorSubject<[Category]>(value: [])
        
        input.networkTrigger
            .bind(with: self) { owner, _ in
                NetworkManager.shared.readPost(productId: "herecome") { value in
                    tableViewList.onNext(value)
                }
                
//                collectionViewList.onNext(categories)
            }
            .disposed(by: disposeBag)
    
        
        input.pullToRefresh
            .bind(with: self) { owner, _ in
                
                NetworkManager.shared.readPost(productId: "herecome") { value in
                    tableViewList.onNext(value)
                }
            }
            .disposed(by: disposeBag)

        		
        selectedValue
            .bind(with: self) { owner, value in
                NetworkManager.shared.readPost(productId: "herecome_\(value)") { value in
                    tableViewList.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList, collectionViewList: collectionViewList)
    }
    
}
