//
//  CommentViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/24/24.
//

import Foundation
import RxSwift
import RxCocoa

final class CommentViewModel {
    
    let disposeBag = DisposeBag()
    let networkTrigger = BehaviorRelay<String>(value: "")
    
    struct Input {
        let sendButtonTap: ControlEvent<Void>
        let inputText: ControlProperty<String>
    }
    
    struct Output {
        let updateTableView: BehaviorSubject<[Comment]>
    }
    
    func transform(input: Input) -> Output {
        
        let updateTableView = BehaviorSubject<[Comment]>(value: [])
        
        networkTrigger
            .bind(with: self) { owner, value in
                NetworkManager.shared.readOnePost(postId: value) { value in
                    updateTableView.onNext(value.comments ?? [])
                }
            }
            .disposed(by: disposeBag)
        
        input.sendButtonTap
            .withLatestFrom(input.inputText)
            .bind(with: self) { owner, value in
                NetworkManager.shared.makeComment(postId: owner.networkTrigger.value, comment: value) { value in
                    NetworkManager.shared.readOnePost(postId: owner.networkTrigger.value) { value in
                        updateTableView.onNext(value.comments ?? [])
                        NotificationCenter.default.post(name: NSNotification.Name("updatePost"), object: nil, userInfo: nil)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(updateTableView: updateTableView)
    }
    
    
}
