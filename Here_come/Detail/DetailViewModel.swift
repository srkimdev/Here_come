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
    var currentPost = BehaviorRelay<String>(value: "")
    
    struct Input {
        let inputText: ControlProperty<String>
        let inputButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let getPost: PublishSubject<Posts?>
        let ImageArray: PublishSubject<[String]>
        let updateComment: PublishSubject<[Comment]>
    }
    
    func transform(input: Input) -> Output {
        
        let getPost = PublishSubject<Posts?>()
        let ImageArray = PublishSubject<[String]>()
        let updateComment = PublishSubject<[Comment]>()
        
        currentPost
            .bind(with: self) { owner, value in
                NetworkManager.shared.readOnePost(postId: value) { value in
                    getPost.onNext(value)
                    ImageArray.onNext(value.files ?? [])
                    updateComment.onNext(value.comments ?? [])
                }
            }
            .disposed(by: disposeBag)
        
        input.inputButtonTap
            .withLatestFrom(input.inputText)
            .bind(with: self) { owner, value in
                
                NetworkManager.shared.makeComment(postId: owner.currentPost.value, comment: value) { value in
                    NetworkManager.shared.readOnePost(postId: owner.currentPost.value) { value in
                        updateComment.onNext(value.comments ?? [])
                    }
                }
                
            }
            .disposed(by: disposeBag)
        
        return Output(getPost: getPost, ImageArray: ImageArray, updateComment: updateComment)
    }
    
}
