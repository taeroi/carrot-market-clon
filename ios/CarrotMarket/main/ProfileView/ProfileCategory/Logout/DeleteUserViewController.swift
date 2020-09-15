//
//  DeleteUserViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/09/09.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class DeleteUserViewController: BaseViewController {
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "로그아웃"
        nickNameLabel.text = USER_NICKNAME
        deleteBtn.layer.cornerRadius = 7
        multipleLineOfTextLabel(nickNameLabel)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        presentAlert(title: "다음에 또 봐요~", message: "")
    }
    
    
    @IBAction func pressedDeleteBtn(_ sender: UIButton) {
        DeleteUserDataManager().deleteUserInfo(self)
        self.navigationController?.popToRootViewController(animated: true)
        removeAllInfo()
    }
    
    // 유저 정보 삭제
    func removeAllInfo(){
        MYTOWN = "" // 동네 이름 초기화
        PLACE_ID = 0   // 동네 ID 값은 JWT 처럼 사용
        PHONENUMBER = "" // 사용자 폰 넘버
        ISMEMBER = 0 // 회원여부 확인 0:비회원, 1:회원
        USER_NICKNAME = "" // 유저 닉네임
        USER_IMAGE = "" // 유저 사진
        MYLATITUDE = 0
        MYLONGITUDE = 0
        DISTANCE = 0
        JWT  = "" //jwt
        POST_ID = 0 //게시글 아이디
        MY_ID = 0
        
        //MARK: - User defaults
        let ismember = ISMEMBER
        let place_id = PLACE_ID
        let phone_number = PHONENUMBER
        let myTown = MYTOWN
        let user_nickname = USER_NICKNAME
        
        let user_image = USER_IMAGE
        let myLatitude = MYLATITUDE
        let mylongitude = MYLONGITUDE
        let distance = DISTANCE
        let jwt = JWT
        
        let post_id = POST_ID
        let myId = MY_ID
        
        let dataSave_ismember = UserDefaults.standard
        let dataSave_place_id = UserDefaults.standard
        let dataSave_phone_number = UserDefaults.standard
        let dataSave_myTown = UserDefaults.standard
        let dataSave_user_nickname = UserDefaults.standard
        
        let dataSave_user_image = UserDefaults.standard
        let dataSave_myLatitude = UserDefaults.standard
        let dataSave_mylongitude = UserDefaults.standard
        let dataSave_distance = UserDefaults.standard
        let dataSave_jwt = UserDefaults.standard
        
        let dataSave_post_id = UserDefaults.standard
        let dataSave_myID = UserDefaults.standard
        
        dataSave_ismember.setValue(ismember, forKey: "save_isMember")
        dataSave_place_id.setValue(place_id, forKey: "save_placeID")
        dataSave_phone_number.setValue(phone_number, forKey: "save_phone_number")
        dataSave_myTown.setValue(myTown, forKey: "save_myTown")
        dataSave_user_nickname.setValue(user_nickname, forKey: "save_user_nickname")
        
        dataSave_user_image.setValue(user_image, forKey: "save_user_image")
        dataSave_myLatitude.setValue(myLatitude, forKey: "save_myLatitude")
        dataSave_mylongitude.setValue(mylongitude, forKey: "save_mylongitude")
        dataSave_distance.setValue(distance, forKey: "save_distance")
        dataSave_jwt.setValue(jwt, forKey: "save_jwt")
        
        dataSave_post_id.setValue(post_id, forKey: "save_post_id")
        dataSave_myID.setValue(myId, forKey: "save_myID")
        
        print("-----------------------------------------------------------------------------------------------------------------------------------\nUSER DEFAULTS INFORMATION \n certificationNumber:\(ISMEMBER)\n, myTown: \(MYTOWN)\n, place ID = \(PLACE_ID)\n, jwt = \(JWT)\n, userNickName = \(USER_NICKNAME)\n, userImage = \(USER_IMAGE)\n, latitude = \(MYLATITUDE)\n, longitude = \(MYLONGITUDE) \n-----------------------------------------------------------------------------------------------------------------------------------")
    }
    
}
