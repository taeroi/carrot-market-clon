//
//  AuthenticateTownResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class AuthenticateTownDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 동네 인증하기 API - no.11
    func postAuthenticateTown(_ mainViewController: AuthenticateTownViewController, _ address: String,_ latitude: Float, _ longitude: Float) {
        
        let body: Parameters = ["address":address,
                                "latitude":latitude,
                                "longitude": longitude
                                ]
        
        //testing 용으로 시행
        let head: HTTPHeaders = ["x-access-token":"\(JWT)"]

        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/neighborhood-auth", method: .post, parameters: body, encoding: JSONEncoding.default, headers: head)
            
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <AuthenticateTownResponse>) in
                switch response.result {
                case .success(let authenticateTownResponse):
                    if authenticateTownResponse.code == 200 {
                        print("\(authenticateTownResponse.message!)")
                        
                    } else {
                         print("\(authenticateTownResponse.message!)")
                        
                    }
                case .failure:
                    print("네트워크 연결 실패")
                }
            })
    }
}
