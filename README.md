# 여기올레 - 제주 한달살기 커뮤니티
> 제주도에서 한달살기를 경험했거나 현재 하고있는 사람들이 정보를 공유하고 소통할 수 있는 앱
<br/>

## 스크린샷

|![Simulator Screenshot - iPhone 15 Pro - 2024-10-17 at 20 32 15](https://github.com/user-attachments/assets/fcf48aab-4a52-44f0-aff7-77d244318eee)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-17 at 20 32 38](https://github.com/user-attachments/assets/d4cd0c25-0f37-4efd-8a4d-09aaf10ad3c2)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-17 at 16 26 24](https://github.com/user-attachments/assets/dd9b5180-1655-4a2a-be1c-5d9c1ec05a40)|![Simulator Screenshot - iPhone 15 Pro - 2024-10-17 at 21 00 27](https://github.com/user-attachments/assets/b24d9142-eedf-4470-86fb-70d8326eface)|
|--|--|--|--|

<br>

## 프로젝트 환경
- 개발 인원:
  - iOS 1명, 서버 1명
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
- UI: `NMapsMap`, `Toast`, `SnapKit`
- Network: `Alamofire`, `Kingfisher`
- 기타: `iamport-ios`

<br/>

## 핵심 기능

- 제주 한달살기 후기 게시글 작성 및 공유 / 좋아요, 댓글 작성
- 제주 한달살기 커뮤니티 운영 / 게시글, 댓글 작성 
- 한달살기 숙소 검색 / 최근 검색어 확인
- 숙소 날짜, 인원 설정 / 지도를 통한 숙소 위치 확인
- 숙소 결제 기능

<br/>
 
## 핵심 기술 구현 사항
- network
네이버지도(사용자 친화적), 카카오search

- ### Access Token 갱신
  - 


- ### 결제
  - 통합결제 API를 연동하여 PG사와 연결
  - 결제 승인 시 결제 내역에 대한 유효성 검증을 위해 서버와 통신하여 최종 결제 여부를 확인 


- ### Dynamic Cell Size
  - UICollectionViewFlowLayout에서 제공하는 estimatedItemSize와 automaticSize를 이용하여 텍스트의 길이에 따라 셀의 크기를 다르게 함   
  - 텍스트의 autoLayout을 verticalEdges, horizontalEdges로 잡아 셀에게 텍스트의 길이에 대한 힌트를 제공함


- ### 사진 업로드 / 로드
  - PHPickerViewController를 사용하여 사진을 선택하고 multipart/form-data방식을 통해 Data타입의 jpeg파일을 서버에 업로드
  - Kingfisher에서 제공하는 setImage함수의 option으로 Header값을 넣어준 AnyModifier를 추가하여 이미지를 로드


- ### 커서 기반 페이지네이션
  - 실시간으로 올라오는 게시글을 대응하기 위해 커서 기반 페이지네이션 도입
  - 각 페이지 마다 서버에서 제공하는 next_cursor변수를 가지고 통신하여 다음 페이지 조회



결제, multipart
dispatchgroup, 셀 크기, 상태코드 처리


<br/>

## 트러블 슈팅
1. 네비게이션 2개 push
2. prepareForReuse
3. 테이블뷰 추가
4. 





