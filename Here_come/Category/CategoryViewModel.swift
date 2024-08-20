//
//  CategoryViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/20/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CategoryViewModel {
    
    let list = [["서핑", "등산", "캠핑", "러닝", "낚시", "드라이브", "스포츠", "수상레포츠"], ["독서", "저녁식사", "파티", "보드게임", "베이킹", "요리", "스터디"], ["스탭 모집", "스탭 구인"]]
    var selectedValue = BehaviorRelay<String>(value: "")
    let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[[String]]>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[[String]]>(value: [])
        
        selectedValue
            .bind(with: self) { owner, _ in
                tableViewList.onNext(owner.list)
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList)
    }
    
}
