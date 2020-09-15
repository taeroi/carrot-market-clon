//
//  MemberIdDataManger.swift
//  ios
//
//  Created by 태로고침 on 2020/09/10.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper


class MemberIdDataManger {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 멤버 아이디 구하기
    func getMemberId(_ mainViewController: ItemDetailViewController) {
        
        // jwt를 통해 유저의 고유 member id를 얻음
        let head: HTTPHeaders = ["x-access-token":"\(JWT)"]
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/jwt", method: .get, encoding: JSONEncoding.default, headers: head)
            
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <MemberIdResponse>) in
                switch response.result {
                case .success(let memberIdResponse):
                    if memberIdResponse.code == 200 {
                        print("\(memberIdResponse.message!)")
                        MY_ID = memberIdResponse.member_id
                        
                        print("User ID: \(memberIdResponse.member_id!)")
                        
                        // 내 아이디를 User Defaults에 저장
                        let dataSave_myId = UserDefaults.standard
                        dataSave_myId.setValue(memberIdResponse.member_id, forKey: "save_myID")
                       
                    } else {
                        print("\(memberIdResponse.message!)")
                        
                    }
                case .failure(let error):
                    print(error, " 네트워크 연결 실패")
                }
            })
    }
    
}

