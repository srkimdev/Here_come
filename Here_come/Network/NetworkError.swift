//
//  NetworkError.swift
//  Here_come
//
//  Created by 김성률 on 8/30/24.
//

import Foundation
import Alamofire

enum APIError: Error {
    
    // 200
    case ok
    
    // 400
    case noNecessaryValue
    
    // 401
    case checkAccount
    
    // 402
    case includeSpace
    
    // 403
    case forbidden
    
    // 409
    case alreadyExist
    
    // 410
    case noPost
    
    // 418
    case refreshTokenExpired
    
    // 419
    case accessTokenExpired
    
    // 420
    case wrongKey
    
    // 429
    case overRequest
    
    // 444
    case abnormalURL
    
    // 445
    case noAuthorization
    
    // 500
    case serverError
    
    case unknown
    
    var description: String {
        switch self {
        case .ok: // 200
            return "ok"
        case .noNecessaryValue: // 400
            return "필수값을 채워주세요. \n유효하지 않은 값 타입 입니다."
        case .checkAccount: // 401
            return "계정을 확인해주세요. \n인증할 수 없는 액세스 토큰입니다."
        case .includeSpace: // 402
            return "공백이 포함된 닉네임은 사용할 수 없습니다."
        case .forbidden: // 403
            return "접근권한이 없습니다."
        case .alreadyExist: // 409
            return "이미 사용중인 닉네임 입니다. \n이미 팔로잉 된 계정입니다. \n검증처리가 완료된 결제건입니다."
        case .noPost: // 410
            return "생성/수정/삭제된 게시글을 찾을 수 없습니다. \n댓글을 추가할 게시글을 찾을 수 없습니다. \n생성/수정/삭제할 댓글을 찾을 수 없습니다. \n알 수 없는 계정입니다."
        case .refreshTokenExpired: // 418
            return "리프레시 토큰이 만료되었습니다. 다시 로그인 해주세요."
        case .accessTokenExpired: // 419
            return "액세스 토큰이 만료되었습니다."
        case .wrongKey: // 420
            return "SesacKey가 없거나 잘못되었습니다."
        case .overRequest: // 429
            return "과호출입니다."
        case .abnormalURL: // 444
            return "비정상적인 url입니다."
        case .noAuthorization: // 445
            return "게시글 수정 권한이 없습니다. \n게시글 삭제 권한이 없습니다. \n댓글 수정 권한이 없습니다. \n댓글 삭제 권한이 없습니다."
        case .serverError: // 500
            return "비정상적인 요청입니다."
        case .unknown:
            return "알 수 없는 에러"
        }
    }
    
    
    static func statusCodeCheck(statusCode: Int) -> APIError {
        switch statusCode {
        case 200:
            return .ok
        case 400:
            return .noNecessaryValue
        case 401:
            return .checkAccount
        case 402:
            return .includeSpace
        case 403:
            return .forbidden
        case 409:
            return .alreadyExist
        case 410:
            return .noPost
        case 418:
            return .refreshTokenExpired
        case 419:
            return .accessTokenExpired
        case 420:
            return .wrongKey
        case 429:
            return .overRequest
        case 444:
            return .abnormalURL
        case 445:
            return .noAuthorization
        case 500:
            return .serverError
            
        default:
            return .unknown
        }
        
    }
    
}
