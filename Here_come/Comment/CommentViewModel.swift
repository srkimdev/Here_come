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
                NetworkManager.shared.callRequest(router: Router.readOnePost(postId: value), responseType: Posts.self) { response in
                    switch response {
                    case .success(let value):
                        updateTableView.onNext(value.comments ?? [])
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.sendButtonTap
            .withLatestFrom(input.inputText)
            .bind(with: self) { owner, value in
                
                let query = CommentQuery(content: value)
                
                NetworkManager.shared.callRequest(router: Router.makeComment(postId: owner.networkTrigger.value, query: query), responseType: CommentResponse.self) { response in
                    switch response {
                    case .success(_):
                        
                        NetworkManager.shared.callRequest(router: Router.readOnePost(postId: owner.networkTrigger.value), responseType: Posts.self) { response in
                            switch response {
                            case .success(let value):
                                updateTableView.onNext(value.comments ?? [])
                                NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(updateTableView: updateTableView)
    }
    
    
}
