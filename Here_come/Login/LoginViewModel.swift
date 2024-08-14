//
//  LoginViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let loginButtonTap: ControlEvent<Void>
        let loginInfo: Observable<(String, String)>
    }
    
    struct Output {
        let loginValidation: PublishSubject<LoginModel>
    }
    
    func transform(input: Input) -> Output {
        
        let loginValidation = PublishSubject<LoginModel>()
        
        // viewmodel에서 통신하는 방법?
        input.loginButtonTap
            .withLatestFrom(input.loginInfo)
            .bind(with: self) { owner, value in
                NetworkManager.shared.accessLogin(id: value.0, password: value.1) { value in
                    loginValidation.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(loginValidation: loginValidation)
        
    }
    
}
