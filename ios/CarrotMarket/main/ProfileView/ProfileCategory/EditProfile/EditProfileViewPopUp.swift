//
//  EditProfileViewPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit
import FirebaseStorage

class EditProfileViewPopUp: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    @IBOutlet weak var nickNameTextfield: UITextField!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var warningView: UIView!
    
    var nickNameTextCount = 0
    
    var storage = Storage.storage() //MARK: - firebase storage 참조 만들기
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameTextfield.delegate = self
        profileImgBtn.layer.cornerRadius = 30
        
        warningView.isHidden = false
        okBtn.isHidden = true
    }
    
    // - imagePickerView
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
            
            //MARK: - firebase에 업로딩
            uploadImg(img: originalImage)
            downloadImg()
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    // MARK: - 닫기 버튼 / 회원 정보 저장 안 됨
    @IBAction func pressedDismissBtn(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 완료 버튼 / 회원 정보 저장됨 ---
    @IBAction func pressedOkBtn(_ sender: UIButton) {
        
        USER_NICKNAME = nickNameTextfield.text!
        USER_IMAGE = ""
        ProfileEditDataManager().patchUserProfile(self, USER_NICKNAME,USER_IMAGE)
        
        let user_nickname = USER_NICKNAME
        let dataSave_user_nickname = UserDefaults.standard
        dataSave_user_nickname.setValue(user_nickname, forKey: "save_user_nickname")
        
        if nickNameTextCount < 2{
            warningView.isHidden = false
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

extension EditProfileViewPopUp: UITextFieldDelegate{
    
    // 텍스트의 글자 체크
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nickNameTextfield{
            self.nickNameTextCount = textField.text?.count as! Int
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

//MARK: - using firebase
extension EditProfileViewPopUp {
    
    // firebase에 사진 업로드
    func uploadImg(img:UIImage){
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "filePath"
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData){
            (metaData, error)in if let error = error{
                print(error.localizedDescription)
                return
            }else{
                print("success!")
            }
        }
    }
    
    //    // firebase에서 사진 다운로드 -> 다운로드 url = gs
    func downloadImg(){
        let storageRef = storage.reference()
        let starsRef = storageRef.child("filePath")
        
        starsRef.downloadURL {url,error in
            if let error = error{
                print(error)
            } else{
                USER_IMAGE = "\(url!)"
                print(USER_IMAGE)
            }
        }
    }
}
