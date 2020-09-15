//
//  LoginViewPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/02.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

// 로그인/회원가입 차
class LoginViewPopUp: BaseViewController{
    
    @IBOutlet weak var authenticationNumberBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var warningLabel: UIButton!
    @IBOutlet weak var termsOfUseLabel: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - 텍스트 필드
    @IBOutlet weak var requirePhoneNumberTextField: UITextField!     // 휴대폰 번호 입력란
    @IBOutlet weak var requireAuthenticationNumberTextField: UITextField! // 인증번호 입력란
    
    var requirePhoneNumberTextCount = 0          // 휴대번호 글자 수 체크
    var requireAuthenticationNumberTextCount = 0 // 인증번호 글자 수 체크
    
    
    // MARK: - 추가 구현 필요!! x 버튼 누르면 로그인 알림창도 내려가야함
    // x 버튼 누르면 로그인뷰 팝업 내림
    @IBAction func dismissBtn(_ sender: UIButton) {
        let loginNoticePopUp = LoginNoticePopUp()
        loginNoticePopUp.dismiss(animated: false, completion: nil)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - 휴대폰 번호로 문자 인증 받기
    @IBAction func requireAuthenticationNumber(_ sender: UIButton) {
        // 버튼 클릭시 문자인증 유효 타이머 시작 & 버튼 색 변경
        
        let phoneNumber = requirePhoneNumberTextField.text!
        
        // 휴대폰 번호는 10자리 이상이 들어가야 작동
        if requirePhoneNumberTextCount < 11{
            presentAlert(title: "휴대폰 자리수가 형식이 맞지 않습니다.", message: "")
        }
        else{
            transformingAuthenticationBtn()
            print("It is not enable", phoneNumber.count)
            print("전화번호: ", phoneNumber)
            showObject()
            PhoneNumberDataManager().getPhoneNumber(self, phoneNumber)
        }
        
    }
    
    
    // MARK: - 인증 번호 입력 후 동의 후 시작 버튼 - 인증 번호 확인 API
    @IBAction func startBtn(_ sender: UIButton) {
        
        // 입력된 인증번호
        let authenticationNumber = requireAuthenticationNumberTextField.text!
        //place_id
        let place_id = PLACE_ID
        
        print("인증번호: ",authenticationNumber)
        
        let phoneNumber = requirePhoneNumberTextField.text!
        
        // MARK: - 인증 번호 네 자리가 눌렸을 때만 API 호출
        if(requireAuthenticationNumberTextCount != 4){
            presentAlert(title: "인증 번호 4자리를 입력주세요. ", message: "")
        }else{
            PhoneNumberDataManager().getAuthenticationNumber(self, phoneNumber, Int(authenticationNumber)!,place_id)
        }
    }
    
            // MARK: - 회원가입이 되어있지 않을 때: 프로필 설정 창으로 이동
            func presentSetProfileViewPopUp(){
                let setProfileViewPopUp = SetProfileViewPopUp()
                setProfileViewPopUp.modalPresentationStyle = .fullScreen
                present(setProfileViewPopUp ,animated: false)
            }
            
            // 회원가입이 되어있을 때: 메인 창으로 이동
            func presentMainView(){
                let mainViewController = MainTabBarController()
                mainViewController.modalPresentationStyle = .fullScreen
                present(mainViewController ,animated: false)
            }
            
            
            var passingDataViewController: SetProfileViewPopUp?
            
            // MARK: - Life Cycle
            override func viewDidLoad() {
                super.viewDidLoad()
                requirePhoneNumberTextField.delegate = self
                requireAuthenticationNumberTextField.delegate = self
                
                showKeyboard()
                hideObject()
                
                multipleLineOfTextLabel(infoLabel)
            }
            
            
            // 프로필 설정 화면으로 이동
            func presentSetProfilePopUp(){
                let presentEditProfilePopUp = UIStoryboard(name: "SetProfileViewPopUp", bundle: Bundle.main)
                guard let popUP = presentEditProfilePopUp.instantiateViewController(withIdentifier: "SetProfileViewPopUp") as? SetProfileViewPopUp else { return }
                popUP.modalPresentationStyle = .custom
                self.present(popUP,animated: true, completion: nil)
                
            }
            
            // MARK: - 인증 번호 받기 버튼 누르기 전까지 라벨, 버튼 숨김
            func hideObject(){
                startBtn.isHidden = true
                warningLabel.isHidden = true
                requireAuthenticationNumberTextField.isHidden = true
                termsOfUseLabel.isHidden = true
            }
            
            // MARK: - 인증 번호 요청 버튼 -> 전화 번호를 요청한 후 버튼을 눌렀을 때 밑 하단의 내용이 보여짐
            // 인증 번호 받기 버튼 누른 후 라벨, 버튼 보여줌
            func showObject(){
                startBtn.isHidden = false
                warningLabel.isHidden = false
                requireAuthenticationNumberTextField.isHidden = false
                termsOfUseLabel.isHidden = false
            }
            
            // 인증번호 문자 받기를 눌렀을 때 사용되는 버튼의 변화를 주는 함수
            // 타이머, 색깔
            func transformingAuthenticationBtn(){
                var minuteRemaining = 5
                var secondsRemaining = 0
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                    // 버튼에 타이머를 탑재
                    
                    self.authenticationNumberBtn.setTitle("인증 문자 다시 받기(\(minuteRemaining)분 \(secondsRemaining)초)", for: .normal)
                    self.authenticationNumberBtn.backgroundColor = .gray
                    
                    if self.authenticationNumberBtn.isSelected == true{
                        minuteRemaining = 0
                        secondsRemaining = 0
                    }
                    //  print("인증 유효 시간: \(minuteRemaining)분 \(secondsRemaining)초")
                    
                    if minuteRemaining == 0 && secondsRemaining == 0{
                        print("Time Over")
                        Timer.invalidate()
                    }
                    else if minuteRemaining > 0 && secondsRemaining == 0{
                        minuteRemaining -= 1
                        secondsRemaining = 59
                    }
                    else if secondsRemaining == 59
                    {
                        secondsRemaining -= 1
                    }
                    else if minuteRemaining > 0 && secondsRemaining > 0 {
                        secondsRemaining -= 1
                    }
                    else{ secondsRemaining -= 1
                        
                    }
                }
            }
            
            
        }
        
        // MARK: - TextField 설정
        extension LoginViewPopUp: UITextFieldDelegate{
            
            //MARK: - 텍스트 스트링 카운트해서 버튼 활성화 (구현 해야함)
            //    func isyoudown(){
            //        guard let length = self.requireAuthenticationNumberTextField.text?.count else{ return }
            //        DispatchQueue.main.async {
            //            self.startBtn.isEnabled = false
            //            if length >= 4{
            //                self.startBtn.isEnabled = true
            //                self.startBtn.backgroundColor = .orange
            //                self.startBtn.tintColor = .white
            //            }
            //        }
            //    }
            
            
            // 키보드에 텍스트가 입력 되면 텍스트 필드위에 있던 글자 없앰
            func textFieldDidBeginEditing(_ textView: UITextField) {
                if textView.text == "휴대폰 번호(- 없이 숫자만 입력)" || textView.text == "인증번호 입력" {
                    textView.text = ""
                    textView.textColor = UIColor.black
                    textView.font = UIFont(name: "verdana", size: 18.0)
                }
            }
            
            func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                if text == "\n" {
                    textView.resignFirstResponder()
                }
                return true
            }
            
            // 글자 수 체크
            func textFieldDidChangeSelection(_ textField: UITextField) {
                if textField == requirePhoneNumberTextField{
                    self.requirePhoneNumberTextCount = textField.text!.count
                    print("전화번호 글자 수 체크: ",requirePhoneNumberTextCount)
                }
                else if textField == requireAuthenticationNumberTextField{
                    self.requireAuthenticationNumberTextCount = textField.text!.count
                    print("인증 번호 글자 수 체크: ",requireAuthenticationNumberTextCount)
                }
            }
            
            func textFieldDidEndEditing(_ textView: UITextField) {
                if textView.text == "" {
                    textView.text = "휴대폰 번호(- 없이 숫자만 입력)"
                    textView.textColor = UIColor.lightGray
                    textView.font = UIFont(name: "verdana", size: 13.0)
                }
            }
            
            //
            func showKeyboard() {
                requirePhoneNumberTextField.becomeFirstResponder()
                requirePhoneNumberTextField.keyboardType = .phonePad
                
                requireAuthenticationNumberTextField.becomeFirstResponder()
                requireAuthenticationNumberTextField.keyboardType = .phonePad
            }
            
            func resignKeyboard(){
                
                // 문자 입력시 placeholder 사라짐
                func textFieldDidBeginEditing(_ textView: UITextField) {
                    if textView.text == "휴대폰 번호(- 없이 숫자만 입력)" {
                        textView.text = ""
                        textView.textColor = UIColor.black
                        textView.font = UIFont(name: "verdana", size: 18.0)
                    }
                }
                
                func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                    if text == "\n" {
                        textView.resignFirstResponder()
                    }
                    return true
                }
                
                func textFieldDidEndEditing(_ textView: UITextField) {
                    if textView.text == "" {
                        textView.text = "휴대폰 번호(- 없이 숫자만 입력)"
                        textView.textColor = UIColor.lightGray
                        textView.font = UIFont(name: "verdana", size: 13.0)
                    }
                }
                
                // 키보드 띄움 - I/O - hardware/keyboard 설정
                func showKeyboard() {
                    requirePhoneNumberTextField.becomeFirstResponder()
                    requirePhoneNumberTextField.keyboardType = .phonePad
                    
                    requireAuthenticationNumberTextField.becomeFirstResponder()
                    requireAuthenticationNumberTextField.keyboardType = .phonePad
                }
                
                // 키보드 내려기
                func resignKeyboard(){
                    requirePhoneNumberTextField.resignFirstResponder()
                    requirePhoneNumberTextField.keyboardType = .phonePad
                    requireAuthenticationNumberTextField.resignFirstResponder()
                    requireAuthenticationNumberTextField.keyboardType = .phonePad
                    
                }
            }
}
