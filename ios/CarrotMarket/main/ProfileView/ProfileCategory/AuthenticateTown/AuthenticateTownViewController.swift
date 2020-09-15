//
//  AuthenticateTownViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/09/05.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AuthenticateTownViewController: BaseViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myTownLabelIfRecognized: UILabel!
    @IBOutlet weak var myTownLabelIfDisrecognized: UILabel!
    @IBOutlet weak var authenticationBtn: UIButton!
    
    @IBAction func pressedAuthenticateTownBtn(_ sender: Any) {
        let address = MYTOWN
        let latitude = MYLATITUDE
        let longitude = MYLATITUDE
        //MARK: - USER DEFAUTLS 데이터 저장
        let dataSave_myTown = UserDefaults.standard
        let dataSave_myLatitude = UserDefaults.standard
        let dataSave_mylongitude = UserDefaults.standard
        
        dataSave_myTown.setValue(address, forKey: "save_myTown")
        dataSave_myLatitude.setValue(latitude, forKey: "save_myLatitude")
        dataSave_mylongitude.setValue(longitude, forKey: "save_mylongitude")
        
        AuthenticateTownDataManager().postAuthenticateTown(self, address, latitude, longitude)
        GoBackAndAlert(title: "\(MYTOWN)으로 동네가 인증되었습니다.", message: "")
      

    }
    
    @IBOutlet weak var warningView1: UIView!
    @IBOutlet weak var warningView2: UIView!
    
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "동네 인증하기"
        myTownLabelIfRecognized.text = MYTOWN
        myTownLabelIfDisrecognized.text = MYTOWN
        authenticationBtn.layer.cornerRadius = 7
        
        showObjectView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // testing - 지도 위도/경도 현재 위치로 설정
        let annotation = MKPointAnnotation()
        annotation.title = "MYTown"
        
        // 맵에 현재 위경도로 내 위치 표시
//        annotation.coordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(MYLATITUDE), longitude: CLLocationDegrees(MYLONGITUDE))

        mapView.addAnnotation(annotation)
    }
    
    @IBAction func detectLocation(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
    func showObjectView(){
        if DISTANCE > 5{
            warningView1.isHidden = false
            warningView2.isHidden = false
        }
        else{
            warningView1.isHidden = true
            warningView2.isHidden = true
        }
    }
    
    
    // 현재 위치 설정
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let coor = manager.location?.coordinate{
                   print("latitude" + String(coor.latitude) + "/ longitude" + String(coor.longitude))
               }
    }
}

