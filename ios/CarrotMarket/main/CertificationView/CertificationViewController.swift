//
//  CertificationViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/09/01.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class CertificationViewController: BaseViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var neighborhoodTableView: UITableView!
    @IBOutlet weak var findByNeighborhoodLocationBtn: UIButton!
    
    var neighborhoods = [Neighborhood]()
    
    var refresh = UIRefreshControl()
    
    var page = 0
    var isRequesting: Bool = true
    var isEnd : Bool = false
    var itemPerpage: Int = 5
    
   
    
    
    //MARK: - 동네검색 버튼 클릭시 주변 동네 검색 API 연결
    @IBAction func pressedgetFindByNeighborhoodLocation(_ sender: UIButton) {
        
        let lat = locationManager.location?.coordinate.latitude
        let lon = locationManager.location?.coordinate.longitude
        
        //        print("lat: \(lat), lon: \(lon)")
        // testcase '경기도 성남시 분당구 율동'의 위/경도
        //        let lat = 37.382746
        //        let lon = 127.151236
        
        NeighborhoodDataManager().getFindByNeighborhoodLocation(self,Float(lat!),Float(lon!),page)
    }
    
    let searchBar = UISearchBar()
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        findByNeighborhoodLocationBtn.layer.cornerRadius = 7
        
        
        // tableview refresh
        refresh.tintColor = UIColor.orange
        refresh.addTarget(self, action: #selector(refreshSwipe), for: .valueChanged)
        neighborhoodTableView.addSubview(refresh) // 테이블뷰에 추가
        
        
        // MARK: - coreLocation
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        //포그라운드 상태에서 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치업데이트
        locationManager.startUpdatingLocation()
        
        // 네비게이션 - 서치바 설정
        setupSearchVCNavItems()
        
        // MARK: - 테이블 뷰 delegate / 설정
        neighborhoodTableView.delegate = self
        neighborhoodTableView.dataSource = self
        
        let neighCellNib = UINib(nibName: "CertificationTableViewCell", bundle: nil)
        self.neighborhoodTableView.register(neighCellNib, forCellReuseIdentifier: "CertificationTableViewCell")
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        neighborhoodTableView.reloadData()
        searchBar.resignFirstResponder()
        
    }
    
    @objc func refreshSwipe(){
        neighborhoodTableView.reloadData()
        refresh.endRefreshing()
    }
   
    
    // 동네 선택시 '동' 단위의 동네 이름만 저장하는 함수
      func splitString(_ townInfo: String) {
          let fullname: String? = townInfo
          let fullNameArr = fullname?.components(separatedBy: " ")
          let lastName: String = (fullNameArr?.last)!
          MYTOWN = lastName
      }
    
    
    // MARK: - coreLocation을 이용하여 현재 위도/경도 구하기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor = manager.location?.coordinate{
            //print("지도에 표시되는 latitude: " + String(coor.latitude) + "/ longitude: " + String(coor.longitude))
            MYLATITUDE = Float(coor.latitude)
            MYLONGITUDE = Float(coor.longitude)
            
            let latitude = MYLATITUDE
            let longitude = MYLONGITUDE
            
            let dataSave_myLatitude = UserDefaults.standard
            let dataSave_mylongitude = UserDefaults.standard
            
            dataSave_myLatitude.setValue(latitude, forKey: "save_myLatitude")
            dataSave_mylongitude.setValue(longitude, forKey: "save_mylongitude")
            
            print("현재 좌표 위치 저장: Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
}

//MARK: - 테이블 뷰 설정 extension

extension CertificationViewController: UITableViewDataSource,UITableViewDelegate{
    //여기서 페이징 구현
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return neighborhoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = neighborhoodTableView.dequeueReusableCell(withIdentifier: "CertificationTableViewCell") as! CertificationTableViewCell?
        
        cell!.neighborhoodNameLabel?.text = neighborhoods[indexPath.row].name!
        print("테이블 위의 동네들: " ,neighborhoods[indexPath.row].name!)
        
        return cell!
    }
    
    
    
    //MARK: - ***  동네 선택시 - 선택된 table cell 동네 정보 저장 ***
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 동네 정보
        let townInfo = neighborhoods[indexPath.row].name!
        let townId = neighborhoods[indexPath.row].id!
        guard let townDistance = neighborhoods[indexPath.row].distance else {print("error: because of not setting of distance"); return }
        
        print("동네 정보 -> ",neighborhoods[indexPath.row])
        //문자열을 나누어 동 단위의 이름만을 저장, 동네 ID, 선택 동네와의 거리 저장
        splitString(townInfo)
        PLACE_ID = townId
        DISTANCE = townDistance
        
        //MARK: - userDefaults 저장
        let myTown = MYTOWN
        let dataSave = UserDefaults.standard
        dataSave.setValue(myTown, forKey: "save_myTown")
        
        print("동네 ID: " ,townId)
        
        //동네 정보를 보내서 저장
        NeighborhoodDataManager().postEnrollNeighborhood(self, townId)
        
        
        let alert = UIAlertController(title: "\(MYTOWN)으로 동네를 설정하였습니다.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction);
        
        if ISMEMBER == 1 {
            self.present(alert, animated: true, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            })
        }
        else{
            //MARK: - 화면 전환
            let mainVC = MainTabBarController()
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC ,animated: false)
        }
    }
    
}


// MARK: - 네비게이션 바 설정
extension CertificationViewController: UISearchBarDelegate,UISearchControllerDelegate {
  
    // MARK: - Helper Functions
    
    func setupSearchVCNavItems() {
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        searchBar.delegate = self
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        // 서치 바의 뷰 설정
        searchBar.sizeToFit()
        searchBar.tintColor = .gray
        searchBar.placeholder = "동명(읍,면)으로 검색 (ex.서초동)"
        
        // 서치 바 나타내기
        search(shouldShow: true)
    }
    
    // MARK: - 서치 바 설정
    func search(shouldShow: Bool) {
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("서치 바 수정 시작")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("서치 바 수정 종료")
    }
    
    // MARK: - 검색창에 검색 시 동네 검색 API 연결
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text test: \(searchText)")
        hideKeyboardWhenTappedAround()
        let latitude = MYLATITUDE
        let longitude = MYLONGITUDE
        
        let count = searchText.count
        print(count)
        NeighborhoodDataManager().getFindSearchedNeighborhood(self, searchText,latitude,longitude,PAGE_NUM_NEIGHBORHOOD)
        neighborhoodTableView.reloadData()
        
        
    }
}

