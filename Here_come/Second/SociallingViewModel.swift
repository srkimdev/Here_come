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
    var selectedValue = BehaviorRelay<String>(value: "전체")
    
    struct Input {
        let networkTrigger: Observable<Void>
    }
    
    struct Output {
        let tableViewList: BehaviorSubject<[Posts]>
        let collectionViewList: BehaviorSubject<[Categories]>
    }
    
    func transform(input: Input) -> Output {
        
        let tableViewList = BehaviorSubject<[Posts]>(value: [])
        let collectionViewList = BehaviorSubject<[Categories]>(value: [])
        
        input.networkTrigger
            .bind(with: self) { owner, _ in
                
                NetworkManager.shared.callRequest(router: Router.readPost(productId: "herecome"), responseType: ReadPostModel.self) { response in
                    switch response {
                    case .success(let value):
                        tableViewList.onNext(value.data)
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
            .disposed(by: disposeBag)

        selectedValue
            .bind(with: self) { owner, value in

                if value == "전체" {
                    NetworkManager.shared.callRequest(router: Router.readPost(productId: "herecome"), responseType: ReadPostModel.self) { response in
                        switch response {
                        case .success(let value):
                            tableViewList.onNext(value.data)
                        case .failure(let error):
                            print(error)
                        }
                    }
                } else {
                    NetworkManager.shared.callRequest(router: Router.readHashTag(hashTag: value), responseType: ReadPostModel.self) { response in
                        switch response {
                        case .success(let value):
                            tableViewList.onNext(value.data)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }

            }
            .disposed(by: disposeBag)
        
        Observable.just(Categories.allCases)
            .bind(with: self) { owner, value in
                collectionViewList.onNext(value)
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: tableViewList, collectionViewList: collectionViewList)
    }
    
}
