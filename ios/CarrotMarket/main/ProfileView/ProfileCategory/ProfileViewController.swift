//
//  ProfileViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/08/30.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var uiMyProfileBtn: UIButton!
    @IBOutlet weak var profileImgBtn: UIButton!
    @IBOutlet weak var notLoginView: UIView!
    @IBOutlet weak var userNickNameLabel: UILabel!
    
    // 프로필 설정 버튼 -> EditProfileViewPopUp으로 이동
    @IBAction func pressedPresentSetProfileViewPopUpBtn(_ sender: UIButton) {
        let ismember = ISMEMBER
        if ismember == 0{
            requireLoginPopUp()
        }else{
            let presentEditProfileViewPopUp = UIStoryboard(name: "EditProfileViewPopUp", bundle: Bundle.main)
            guard let popUP = presentEditProfileViewPopUp.instantiateViewController(withIdentifier: "EditProfileViewPopUp") as? EditProfileViewPopUp else { return }
            popUP.modalPresentationStyle = .custom
            self.present(popUP,animated: true, completion: nil)
        }
    }
    
    // 앱 설정 화면으로 이동하는 버튼
    @IBAction func presentSettingBtn(_ sender: UIButton) {
        let ismember = ISMEMBER
        if ismember == 0{
            requireLoginPopUp()
        } else{
            let navigationViewController = self.navigationController
            navigationViewController?.pushViewController(DeleteUserViewController(), animated: true)
        }
    }
    // 내 동네 설정 버튼 -> 동네 설정 뷰로 이동
    @IBAction func pressedPresentCertificationViewControllerBtn(_ sender: UIButton) {
        let navigationViewController = self.navigationController
        navigationViewController?.pushViewController(CertificationViewController(), animated: true)
    }
    
    // 동네 인증하기 버튼 -> 동네 인증 창으로 이동
    @IBAction func pressedPresentAuthenticateTownViewController(_ sender: UIButton) {
        if ISMEMBER == 0{
            requireLoginPopUp()
        }else{
            let navigationViewController = self.navigationController
            navigationViewController?.pushViewController(AuthenticateTownViewController(), animated: true)
        }
    }
    
    @IBAction func pressedLoginBtn(_ sender: UIButton) {
        presentLoginViewPopUp()
    }
    
    
    
    var a : UIImageView!
    
    // MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "나의 당근"
      //  userNickNameLabel.text = USER_NICKNAME
        
        
        editButton()
        isLogin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.userNickNameLabel.text = USER_NICKNAME
        }
        
    }
    
    // 로그인 여부 판단하여 권한 부여
    func isLogin(){
        if ISMEMBER == 0 {
            notLoginView.isHidden = false
        }else{
            notLoginView.isHidden = true
           
        }
    }
    
    func editButton(){
        self.uiMyProfileBtn.layer.borderWidth = 1.0
        self.uiMyProfileBtn.layer.borderColor = UIColor.gray.cgColor
        self.uiMyProfileBtn.layer.cornerRadius = 5
    }
    
    // 준비 중 팝업
    
    
    // MARK:  - 구현 준비 중
    //profile - 동네생활 글
    @IBAction func pressedPrsesentView4_Btn1(_ sender: UIButton) {
        commingSoonPopUp()
    }
    //profile - 동네생활 댓글
    @IBAction func pressedPrsesentView4_Btn2(_ sender: UIButton) {
        commingSoonPopUp()
    }
    //profile - 동네생활 주제 목록
    @IBAction func pressedPrsesentView4_Btn3(_ sender: UIButton) {
        commingSoonPopUp()
    }
    //profile - 친구 초대
    @IBAction func pressedPrsesentView5_Btn1(_ sender: UIButton) {
        commingSoonPopUp()
    }
    //profile - 당근마켓 공유
    @IBAction func pressedPrsesentView5_Btn2(_ sender: UIButton) {
        commingSoonPopUp()
    }
    //profile - 공지사항
    @IBAction func pressedPrsesentView5_Btn3(_ sender: UIButton) {
        commingSoonPopUp()
    }
    //profile - 자주 묻는 질문
    @IBAction func pressedPrsesentView5_Btn4(_ sender: UIButton) {
        commingSoonPopUp()
    }
    
}
