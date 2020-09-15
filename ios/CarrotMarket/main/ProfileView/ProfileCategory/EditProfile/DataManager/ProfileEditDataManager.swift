//
//  ProfileEditDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/09.
//  Copyright © 2020 Jerry Jung. All rights reserved.


import Alamofire
import AlamofireObjectMapper

class ProfileEditDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 프로필 수정 API - no.9
    func patchUserProfile(_ mainViewController: EditProfileViewPopUp, _ nickName: String, _ profile_url: String) {
        
        let body: Parameters = ["nick_name": nickName ,
                                "profile_url": profile_url
                                ]
        
        //testing 용으로 시행
        let head: HTTPHeaders = ["x-access-token" : "\(JWT)"]
        Alamofire
            .request("\(self.appDelegate.baseUrl)/member", method: .patch, parameters: body, encoding: JSONEncoding.default, headers: head)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <ProfileEditResponse>) in
                switch response.result {
                case .success(let profileEditResponse):
                    if profileEditResponse.code == 200 {
                        print("\(profileEditResponse.message!)")
                     
                    } else {
                         print("\(profileEditResponse.message!)")
                        
                    }
                case .failure(let error):
                    print(error,"네트워크 연결 실패")
                }
            })
    }
}
