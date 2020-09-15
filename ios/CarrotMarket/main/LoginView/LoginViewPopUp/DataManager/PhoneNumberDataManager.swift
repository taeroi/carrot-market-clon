//
//  CertificationMessageDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/03.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper

class PhoneNumberDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    // MARK: - 인증번호 요청 API - no.4
    func getPhoneNumber(_ loginViewPopUp: LoginViewPopUp, _ phoneNumber: String) {
        
        let body: Parameters = ["phone_number":phoneNumber]
        //testing
        print("PostPhoneNumber/ Body: ", body)
        PHONENUMBER = phoneNumber   // 폰 넘버 저장
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/auth-message", method: .post, parameters: body,encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <PhoneNumberResponse>) in
                switch response.result {
                case .success(let phoneNumberResponse):
                    if phoneNumberResponse.code == 200 {
                        print("\(phoneNumberResponse.message!)")
                    
                    } else {
                        print("인증 요청 실패")
                       
                    }
                case .failure(let error):
                    print("휴대전화 형식이 아닙니다.")
                    print(error.localizedDescription)
                }
            })
    }
    //MARK: - 인증번호 확인 API 연결 - no.5
    func getAuthenticationNumber(_ loginViewPopUp: LoginViewPopUp,_ phoneNumber: String,_ randNumber: Int,_ place_id: Int)  {
        
        let body: Parameters = [
            "phone_number": phoneNumber,
            "rand_number": randNumber,
            "place_id" : place_id
        ]

        Alamofire
            .request("\(self.appDelegate.baseUrl)/auth", method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <AuthenticationNumberResponse>) in
                switch response.result {
                case .success(let authenticationNumberResponse):
                    
                    
                    if authenticationNumberResponse.code == 200 {
                        print("\(authenticationNumberResponse.message!)")
                        print("is_signup: \(authenticationNumberResponse.is_signup!)")
                        if authenticationNumberResponse.jwt == ""{
                        print("**** jwt: \(authenticationNumberResponse.jwt!) ****")
                        }
                    
                        ISMEMBER = authenticationNumberResponse.is_signup
                        JWT = authenticationNumberResponse.jwt
                        print(JWT)
                        
                        let ismember = ISMEMBER
                        let jwt = JWT
                        
                        let dataSave_ismember = UserDefaults.standard
                        let dataSave_jwt = UserDefaults.standard
                        
                        dataSave_ismember.setValue(ismember, forKey: "save_isMember")
                        dataSave_jwt.setValue(jwt, forKey: "save_jwt")

//                        // 0: 회원가입폼, 1: 로그인 성공
                        // 회원 가입이 안 되어 있을 때 - 프로필 작성 창으로 이동
                        if authenticationNumberResponse.is_signup == 0 {
                            loginViewPopUp.presentSetProfilePopUp()
                        }
                        // 회원 가입이 되어 있을 떄 - 메인 창으로 이동
                        else if authenticationNumberResponse.is_signup == 1 {
                            //loginViewPopUp.dismiss(animated: true, completion: nil)
                            loginViewPopUp.presentMainView()
                        }
                        
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
