//
//  LocationDataManagerViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/09/01.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//
//

import Alamofire
import AlamofireObjectMapper

class NeighborhoodDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 주변 동네 검색 - 등록된 위치의 위/경도로 가까운 동네 검색  =================================== TESTING!!!!!!===================================page_num
    
    func getFindByNeighborhoodLocation(_ certificationViewController: CertificationViewController, _ lat: Float, _ lon: Float, _ page_num: Int ) {
        Alamofire
            // QueryString 으로 latitude / longitude -> 위도값, 경도값
            .request("\(self.appDelegate.baseUrl)/nearby?latitude=\(lat)&longitude=\(lon)&page_num=\(page_num)", method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <NeighborhoodResponse>) in
                switch response.result {
                case .success(let neighborhoodResponse):
                    if neighborhoodResponse.code == 200 {
                        print("\(neighborhoodResponse.message!)")
                        
                        certificationViewController.neighborhoods = neighborhoodResponse.neighborhoods
                        
                        //testing
                        print("동네정보: ",certificationViewController.neighborhoods)
                        certificationViewController.neighborhoodTableView.reloadData()
                        
                    } else {
                        print("동네 조회 실패")
                        
                    }
                case .failure:
                    print("네트워크 연결 실패")
                }
            })
    }
    
    //MARK: - 동네검색 네트워크 - 동네 검색 =================================== TESTING!!!!!!===================================page_num
    func getFindSearchedNeighborhood(_ certificationViewController: CertificationViewController, _ searchedString: String,_ latitude: Float, _ longitude: Float ,_ page_num: Int){
        Alamofire
            //MARK: - URL Encoding, QueryString 으로 동네이름
            .request(("\(self.appDelegate.baseUrl)/search?search=\(searchedString)&latitude=\(latitude)&longitude=\(longitude)&page_num=\(page_num)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <NeighborhoodResponse>) in
                switch response.result {
                case .success(let neighborhoodResponse):
                    if neighborhoodResponse.code == 200 {
                        print("동네 검색 성공!")
                        
                        //테이블에 데이터 할당
                        certificationViewController.neighborhoods = neighborhoodResponse.neighborhoods
                        certificationViewController.neighborhoodTableView.reloadData()
                        
                    } else {
                        print("동네 검색 실패")
                        
                    }
                case .failure(let error):
                    print("네트워크 연결 실패")
                    print(error.localizedDescription)
                }
            })
    }
    
    //MARK:-  동네등록설정 네트워크 - 동네 ID를 얻음
    func postEnrollNeighborhood(_ certificationViewController: CertificationViewController, _ placeId: Int){

        //- parameter
        let body: Parameters = ["place_id" : placeId]
        //testing
        print("Body: ", body)
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/neighborhood", method: .post, parameters: body,encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <EnrollNeighborhoodTownResponse>) in
                switch response.result {
                case .success(let enrollNeighborhoodTownResponse):
                    if enrollNeighborhoodTownResponse.code == 200 {
                        
                        print("동네 id : \(enrollNeighborhoodTownResponse.message!)")
                        print("동네 id가 저장 되었습니다! \(String(describing: enrollNeighborhoodTownResponse.id))")
                        
                    } else {
                        print("인증 요청 실패")
                        
                    }
                case .failure(let error):
                    print("네트워크 연결 실패")
                    print(error.localizedDescription)
                }
            })
    }
    
}
