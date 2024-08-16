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
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void>
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[[Party]]>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[[Party]]>(value: [])
        
        let a = input.viewDidLoadTrigger
            .map{Parties}
//            .bind(to: tableViewList)
            .bind(with: self) { owner, value in
                tableViewList.onNext(value)
                print("onnext")
            }
            .disposed(by: disposeBag)
        
        tableViewList.subscribe { parties in
            print("🥵", parties)
        }
        .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList)
    }
    
}
