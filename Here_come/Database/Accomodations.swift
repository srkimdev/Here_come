//
//  Accomodations.swift
//  Here_come
//
//  Created by 김성률 on 8/14/24.
//

import Foundation

struct House {
    let image: [String]
    let location: String
    let title: String
    let price: String
    let latitude: Double
    let longitude: Double
    let address: String
}

let houses: [House] = [
    House(image: ["1-1", "1-2", "1-3", "1-4", "1-5"], location: "제주시 조천읍", title: "제주 한달살기 감성숙소 독채 펜션 제주도 한달살이 일주일 보름살기 임대 25년예약가능", price: "350,000원", latitude: 33.49119, longitude: 126.6826, address: "제주 제주시 조천읍 와선로 1"
),
    House(image: ["2-1", "2-2", "2-3", "2-4", "2-5"], location: "제주시 한림읍", title: "제주 2주살기 한달살기 보름살기 독채 오션뷰 조용한 나만의 테라스가 있는 감성숙소", price: "1,950,000원", latitude: 33.39316, longitude: 126.2706, address: "제주 제주시 한림읍 한림중앙로 250-52 루디아의 테라스"),
    House(image: ["3-1", "3-2", "3-3", "3-4", "3-5"], location: "제주시 협재리", title: "제주 한달살기 펜션 한달살이 독채 숙소 협재 바다의 선물 임대 보름살기", price: "1,600,000원", latitude: 33.37817, longitude: 126.2546, address: "제주 제주시 한림읍 협재남6길 78-160 에이동"),
    House(image: ["4-1", "4-2", "4-3", "4-4", "4-5"], location: "서귀포시 성산읍", title: "[한달살기, 일주일, 보름 살기] 친구,부모님 동반 동부 오션뷰 숙소 제주도 서귀포시 성산읍 신산리 바다 바닷가 인근 뷰좋은 서귀포 감성 독채 민박 동쪽 일출 펜션 스톤스테이", price: "300,000원", latitude: 33.37890, longitude: 126.8747, address: "제주 서귀포시 성산읍 일주동로 5134-1 1층"),
    House(image: ["5-1", "5-2", "5-3", "5-4", "5-5"], location: "제주시 애월읍", title: "제주 일주일살기 감성 독채 애월 숙소 안목오감도", price: "1,750,000원", latitude: 33.46751, longitude:  126.3971, address: "제주 제주시 애월읍 예원북길 29"),
    House(image: ["6-1", "6-2", "6-3", "6-4", "6-5"], location: "서귀포시 중문동", title: "제주 한달살기 한달살이 보름살기 보름살이 독채 오션뷰 조용한 나만의 테라스가 있는 감성숙소(최대 3인)", price: "3,200,000원", latitude: 33.55010, longitude: 126.6991, address: "제주 제주시 조천읍 북촌14길 1-14 407동")
]

