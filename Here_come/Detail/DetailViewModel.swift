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
    
    var comment: [String] = []
    let disposeBag = DisposeBag()
    
    struct Input {
        let inputText: ControlProperty<String>
    }
    
    struct Output {
        let updateTableView: BehaviorSubject<[Comment]>
    }
    
    func transform(input: Input) -> Output {
        
        let updateTableView = BehaviorSubject<[Comment]>(value: [])
        
        input.inputText
            .bind(with: self) { owner, value in
                
//                NetworkManager.shared.makeComment(postId: "66c6ed92078fb670167b2cc3", comment: "ddd")
                
                NetworkManager.shared.readOnePost(postId: "66c6ed92078fb670167b2cc3") { value in
                    print(value, "here")
                    updateTableView.onNext(value.comments ?? [])
                }
                
//                owner.comment.append(value)
//                updateTableView.onNext(owner.comment)
            }
            .disposed(by: disposeBag)
        
        return Output(updateTableView: updateTableView)
    }
    
}
