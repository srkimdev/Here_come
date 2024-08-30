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
                
                NetworkManager.shared.callRequest(router: .readPost(productId: "herecomePost"), responseType: ReadPostModel.self) { response in
                    switch response {
                    case .success(let value):
                        tableViewList.onNext(value.data)
                    case .failure(let error):
                        print("readPost", error)
                    }
                }

            }
            .disposed(by: disposeBag)
        
        likeButtonTap
            .bind(with: self) { owner, _ in
                
                let query = LikeQuery(like_status: UserDefaults.standard.bool(forKey: owner.likeButtonTap.value))
                
                NetworkManager.shared.callRequest(router: Router.likePost(postId: owner.likeButtonTap.value, query: query), responseType: LikeModel.self) { response in
                    switch response {
                    case .success(let value):
                        currentLike.onNext(value.like_status)
                        let bool = UserDefaults.standard.bool(forKey: self.likeButtonTap.value)
                        UserDefaults.standard.set(!bool, forKey: self.likeButtonTap.value)
                    case .failure(let error):
                        print(error)
                    }
                }

            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList, updateLike: currentLike)
    }
    
}
