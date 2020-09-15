//
//  DeleteUserDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/09.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class DeleteUserDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 동네 인증하기 API - no.11
    func deleteUserInfo(_ mainViewController: DeleteUserViewController) {
        
        //testing 용으로 시행
        let head: HTTPHeaders = ["x-access-token":"\(JWT)"]
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/member", method: .delete, encoding: JSONEncoding.default, headers: head)
            
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <DeleteUserResponse>) in
                switch response.result {
                case .success(let deleteUserResponse):
                    if deleteUserResponse.code == 200 {
                        print("\(deleteUserResponse.message!)")
                        
                    } else {
                         print("\(deleteUserResponse.message!)")
                        
                    }
                case .failure:
                    print("네트워크 연결 실패")
                }
            })
    }
}
