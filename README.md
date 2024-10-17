## 여기올레 - 제주 한달살기 커뮤니티
- 
<br/>

## 스크린샷

|--|--|--|--|


## 프로젝트 환경
- 개발 인원:
  - 1명
- 개발 기간:
  - 24.08.17 - 24.08.31 ( 15일 )
- 개발 환경:

    | iOS version | <img src="https://img.shields.io/badge/iOS-16.0+-black?logo=apple"/> |
    |:-:|:-:|
    | Framework | UIKit |
    | Architecture | MVVM |
    | Reactive | RxSwift |

<br/>

## 기술 스택 및 라이브러리
- UI: `NMapsMap`, `Toast`, `SnapKit`, 
- Network: `Alamofire`, `Kingfisher`
- 기타: `iamport-ios`

<br/>

## 핵심 기능

- 제주 한달살기 후기 게시글 쓰기 / 공유 
- 제주 한달살기 커뮤니티
- 

<br/>
 
## 핵심 기술 구현 사항
- network
네이버지도, 카카오search

  - Alamofire의 URLRequestConvertible 프로토콜을 채택한 TargetType 프로토콜과 이를 사용한 라우터 패턴을 정의해 다양한 네트워크 통신을 처리
  - Google TTS와 같이 시간이 오래 걸릴 수 있는 통신에 대응하기 위해 NetworkManager를 비동기로 구현
 

 
- Charts
<br/>

## 트러블 슈팅
1. 상위뷰 아래 서로 다른 하위뷰 2개가 동일한 데이터를 처리하고 있는 경우
