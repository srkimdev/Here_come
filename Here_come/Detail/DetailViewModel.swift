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
                NetworkManager.shared.callRequest(router: Router.readOnePost(postId: value), responseType: Posts.self) { response in
                    switch response {
                    case .success(let value):
                        getPost.onNext(value)
                        ImageArray.onNext(value.files ?? [])
                        updateComment.onNext(value.comments ?? [])
                    case .failure(let error):
                        print("readOnePost", error)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        input.inputButtonTap
            .withLatestFrom(input.inputText)
            .bind(with: self) { owner, value in
                
                let query = CommentQuery(content: value)
                
                NetworkManager.shared.callRequest(router: Router.makeComment(postId: owner.currentPost.value, query: query), responseType: CommentResponse.self) { response in
                    switch response {
                    case .success(_):
                        
                        NetworkManager.shared.callRequest(router: Router.readOnePost(postId: owner.currentPost.value), responseType: Posts.self) { response in
                            switch response {
                            case .success(let value):
                                updateComment.onNext(value.comments ?? [])
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
        
        return Output(getPost: getPost, ImageArray: ImageArray, updateComment: updateComment)
    }
    
}
