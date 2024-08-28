//
//  ShowMapViewModel.swift
//  Here_come
//
//  Created by 김성률 on 8/28/24.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class ShowMapListViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let inputText: ControlProperty<String>
        let searchBarEnter: ControlEvent<Void>
    }
    
    struct Output {
        let addressInfo: PublishSubject<[AddressInfo]>
    }
    
    func transform(input: Input) -> Output {
        
        let addressInfo = PublishSubject<[AddressInfo]>()
        
        input.searchBarEnter
            .withLatestFrom(input.inputText)
            .bind(with: self) { owner, value in
                owner.callRequest(keyword: value) { value in
                    print(value)
                    addressInfo.onNext(value)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(addressInfo: addressInfo)
    }
    
    private func callRequest(keyword: String, completionHandler: @escaping ([AddressInfo]) -> Void) {
        let url = "https://dapi.kakao.com/v2/local/search/keyword.json"
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK " + APIKey.kakaoSecretKey
        ]
        
        let parameters: [String: Any] = [
            "query": keyword,
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate(statusCode: 200...300)
            .responseDecodable(of: MapModel.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.documents)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
}
