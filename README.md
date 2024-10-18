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

- ### Access Token 갱신
  - Alamofire의 RequestIntercepter 프로토콜을 채택하여 adapt, retry 로직 구현 
  - Access Token 만료 시 retry함수를 거쳐 새로운 엑세스 토큰 발급
  - Refresh Token 만료 시 로그인 화면으로 이동

<br>

- ### 장소 검색 및 위치 확인
  - 장소 검색을 위해 Kakao search API를 이용하였고 장소명과 좌표값 추출
  - MapKit과 비교했을 때 사용자에게 좀 더 친숙한 네이버 지도를 이용하여 숙소 위치를 보여줌
 
<br>

- ### 결제
  - 통합결제 API를 연동하여 PG사와 연결
  - 결제 승인 시 결제 내역에 대한 유효성 검증을 위해 서버와 통신하여 최종 결제 여부를 확인

<br>

- ### Dynamic Cell Size
  - UICollectionViewFlowLayout에서 제공하는 estimatedItemSize와 automaticSize를 이용하여 텍스트의 길이에 따라 셀의 크기를 다르게 함   
  - 텍스트의 autoLayout을 verticalEdges, horizontalEdges로 잡아 셀에게 텍스트의 길이에 대한 힌트를 제공함

<br>

- ### 사진 업로드 / 로드
  - PHPickerViewController를 사용하여 사진을 선택하고 multipart/form-data방식을 통해 Data타입의 jpeg파일을 서버에 업로드
  - Kingfisher에서 제공하는 setImage함수의 option으로 Header값을 넣어준 AnyModifier를 추가하여 이미지를 로드
  - 이미지 로드 시 여러 이미지들이 비동기적으로 로드되는 것을 동기화하기 위해 dispatchGroup을 사용

<br>

- ### 커서 기반 페이지네이션
  - 실시간으로 올라오는 게시글을 대응하기 위해 커서 기반 페이지네이션 도입
  - 각 페이지 마다 서버에서 제공하는 next_cursor변수를 가지고 통신하여 다음 페이지 조회

<br/>

## 트러블 슈팅
### 1. Dynamic Cell Size를 적용하였지만 이전 셀의 데이터가 남아있는 문제
- 상황
  - 숙소 검색 화면에서 지역 검색 시 최근 검색어에는 검색어의 목록이 컬렉션뷰로 보여지게 되고 검색어의 길이에 따라 셀의 크기를 다르게 설정하였음
  - 첫번째 검색어는 텍스트의 크기에 맞게 셀이 만들어졌지만 두번째 검색부터는 이전 검색어 셀과 똑같은 셀의 크기를 가지거나 잘 잡지 못함
   
      <img width="201" alt="스크린샷 2024-10-18 오후 7 50 04" src="https://github.com/user-attachments/assets/eb919ce7-4436-4e78-828e-92bb08db4163">
  
- 원인 분석
  - 이전 셀이 가지고 있는 내용과 상태를 초기화해줄 필요가 있음
  - UICollectionViewCell의 prepareForReuse를 호출하는 과정에서 부모 클래스의 prepareForReuse를 호출하지 않았음

- 해결
  - super.prepareForReuse를 호출하여 부모클래스에서 prepareForReuse가 수행하는 기본동작을 실행하도록 함
  <br>

     ```swift
     override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
     }
     ```
<br>

### 2. 처음 화면 진입 시 trigger를 주어 네트워크 통신을 하지만 데이터를 받아오지 못하는 문제
- 상황
  - 게시물 공유 화면 진입 시 PublishSubject로 선언된 viewDidLoadTrigger를 통해 viewModel에서 네트워크 통신을 하고 받아온 게시물을 보여줌
  - viewDidLoadTrigger가 viewModel의 Input으로 들어가고 네트워크 통신하도록 바인드 되어 있음
 
- 원인 분석
  - PublishSubject는 bind를 걸어주고 난 후에 이벤트가 방출된 것을 구독하는 특징이 있음
  - 처음에 viewDidLoadTrigger가 viewModel과 연결되어 바인드 되어있는 것은 맞지만 그 이후에 방출되는 이벤트가 없기 때문에 네트워크 통신을 하지 않음
 
- 해결 
  - 시점 문제를 해결하기 위해 구독할 때 처음에 가지고 있는 값을 바로 방출해줄 수 있는 BehaviorSubject를 사용함
  <br>
    
     ```swift
     let viewDidLoadTrigger = BehaviorSubject<Void>(value: ())
     let input = AccomodationViewModel.Input(networkTrigger: viewDidLoadTrigger)
     ```
    
    







