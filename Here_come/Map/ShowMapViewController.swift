//
//  ShowMapViewController.swift
//  Here_come
//
//  Created by 김성률 on 8/25/24.
//

import UIKit
import SnapKit
import MapKit

final class ShowMapViewController: BaseViewController {
    
    let mapView = MKMapView()
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        searchBar.delegate = self
        
    }
    
    override func configureHierarchy() {
        
        view.addSubview(mapView)
        view.addSubview(searchBar)
        
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(44)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "숙소의 주소, 지역명 등을 입력해주세요"
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.3617, longitude: 126.5292), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap))
        mapView.addGestureRecognizer(tapGesture)
                                             
    }
    
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        // 좌표를 주소로 변환
        let geocoder = CLGeocoder()
        let address = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(address) { placemarks, error in
            
            if let error = error {
                print("Error reverse geocoding: \(error)")
                return
            }
            
            if let placemark = placemarks?.first {
                let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                print("Tapped location address: \(address)")
                
                self.addAnnotation(at: coordinate, with: address)
                
            }
        }
    }
    
    
}

extension ShowMapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func searchLocation(locationName: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(locationName) { [weak self] placemarks, error in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("error geocoding")
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            guard let location = placemark.location else { return }
            
            let coordinate = location.coordinate
            strongSelf.centerMapOnLocation(coordinate: coordinate)
            
        }
        
    }
    
    func centerMapOnLocation(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func addAnnotation(at coordinate: CLLocationCoordinate2D, with address: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Tapped Location"
        annotation.subtitle = address
        mapView.addAnnotation(annotation)
        
        // 지도를 어노테이션 위치로 이동
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
}

extension ShowMapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        
        searchLocation(locationName: searchText)
        
    }
    
}
