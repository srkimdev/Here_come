//
//  SellingViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/25/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SellingViewModel {
    
    let disposeBag = DisposeBag()
    var textStore: [String] = UserDefaultsManager.shared.searchTextStore
    
    struct Input {
        let networkTrigger: PublishSubject<Void>
        let inputText: PublishSubject<String>
    }
    
    struct Output {
        let updateTableView: BehaviorSubject<[House]>
        let updateRecentText: BehaviorSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        let updateTableView = BehaviorSubject<[House]>(value: [])
        let updateRecentText = BehaviorSubject<[String]>(value: textStore)
        
        input.networkTrigger
            .bind(with: self) { owner, _ in
                updateTableView.onNext(houses)
            }
            .disposed(by: disposeBag)
        
        input.inputText
            .bind(with: self) { owner, value in
                owner.topToRecentSearch(search: value)
                updateRecentText.onNext(owner.textStore)
            }
            .disposed(by: disposeBag)
        
        return Output(updateTableView: updateTableView, updateRecentText: updateRecentText)
    }
    
    private func topToRecentSearch(search: String) {
        if let index = textStore.firstIndex(of: search) {
            textStore.remove(at: index)
        }
        textStore.insert(search, at: 0)
        UserDefaultsManager.shared.searchTextStore = textStore
    }
    
}
