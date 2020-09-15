//
//  SetMemberProfileDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/04.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class SetMemberProfileDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // MARK: - 전화번호 서버 연결
    func postMemberProfile(_ loginViewPopUp: SetProfileViewPopUp, _ place_id: Int, _ nick_name: String, _ profile_url: String,_ phone_number: String ) {

        let body: Parameters = [
            "place_id" : place_id,
            "nick_name" : nick_name,
            "profile_url" : profile_url,
            "phone_number" : phone_number
        ]

        //testing
        print("postMemberProfile Body: ", body)

        Alamofire
            .request("\(self.appDelegate.baseUrl)/member", method: .post, parameters: body,encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <SetMemberProfileResponse>) in
                switch response.result {
                case .success(let memberResponse):
                    if memberResponse.code == 200 {
                        print("\(memberResponse.message!)")

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
