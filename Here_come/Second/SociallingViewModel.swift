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
    var selectedIndexPath = BehaviorRelay<Int>(value: 0)
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void>
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[Party]>
        let collectionViewList: BehaviorSubject<[Category]>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[Party]>(value: [])
        let collectionViewList = BehaviorSubject<[Category]>(value: [])
        
        input.viewDidLoadTrigger
            .bind(with: self) { owner, _ in
                tableViewList.onNext(Parties)
                collectionViewList.onNext(categories)
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList, collectionViewList: collectionViewList)
    }
    
}
