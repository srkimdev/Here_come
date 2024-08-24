//
//  AccomodationViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class AccomodationViewModel {
    
    let disposeBag = DisposeBag()
    
    let likeButtonTap = BehaviorRelay<String>(value: "")
    
    struct Input {
        let networkTrigger: Observable<Void>
        let pullToRefresh: PublishSubject<Void>
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[Posts]>
        let updateLike: PublishSubject<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[Posts]>(value: [])
        let currentLike = PublishSubject<Bool>()
        
        input.networkTrigger
            .bind(with: self) { owner, _ in
                NetworkManager.shared.readPost(productId: "herecomePost") { value in
                    tableViewList.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        input.pullToRefresh
            .bind(with: self) { owner, _ in
                NetworkManager.shared.readPost(productId: "herecomePost") { value in
                    tableViewList.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        likeButtonTap
            .bind(with: self) { owner, _ in
                NetworkManager.shared.likePost(postId: owner.likeButtonTap.value) { value in
                    currentLike.onNext(value.like_status)
                    var bool = UserDefaults.standard.bool(forKey: self.likeButtonTap.value)
                    UserDefaults.standard.set(bool.toggle(), forKey: self.likeButtonTap.value)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList, updateLike: currentLike)
    }
    
}
