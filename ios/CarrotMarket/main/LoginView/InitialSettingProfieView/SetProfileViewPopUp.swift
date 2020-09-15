//
//  SignUpViewPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/04.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class SetProfileViewPopUp: BaseViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var nickNameTextfield: UITextField!
    @IBOutlet weak var okBtn: UIButton!
    
    var nickNameTextCount = 0
    
    //warning View!!
    @IBOutlet weak var warningView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nickNameTextfield.delegate = self
        profileImgBtn.layer.cornerRadius = 20
        okBtn.isHidden = true
        warningView.isHidden = false
    }
    
    
    // MARK: - 닫기 버튼 / 회원 정보 저장 안 됨
    @IBAction func pressedDismissBtn(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 완료 버튼 / 회원 정보 저장됨
    @IBAction func pressedOkBtn(_ sender: UIButton) {
        
        print("success set the profile view pop up")
        
        let placeID = PLACE_ID
        let userNickName = nickNameTextfield.text!
        let userProfile = "park.jpg" //임의의 데이터
        let phoneNumber = PHONENUMBER
        USER_NICKNAME = userNickName
        
        print("placeID: ", placeID)
        print("userNickName: ",userNickName)
        print("phoneNum: ", phoneNumber)
        
        SetMemberProfileDataManager().postMemberProfile(self, placeID, userNickName, userProfile, phoneNumber)
        
        // 완료 버튼을 누르면 홈으로 돌아감
        let homeVC = HomeViewController()
        present(homeVC,animated: true)
    }
    
    
    // imagePickerView
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    //MARK: - 프사 변경
    @IBOutlet weak var profileImgBtn: UIButton! //프로필 사진
    
    // 프사를 누르면 사진을 업로드 피커 뷰가 나타남
    @IBAction func uploadBtn(_ sender: UIButton) {
        self.present(self.imagePicker, animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImgBtn.setImage(originalImage, for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SetProfileViewPopUp: UITextFieldDelegate{
    
    // 텍스트의 글자 체크
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nickNameTextfield{
            self.nickNameTextCount = Int(textField.text!)!
            print("닉네임 글자 수 체크: ",nickNameTextCount)
            
            if nickNameTextCount < 2{
                okBtn.isHidden = true
                warningView.isHidden = false
            }
            else{
                okBtn.isHidden = false
                warningView.isHidden = true
            }
            
        }
    }
}
