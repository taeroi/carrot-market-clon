//
//  BaseViewController.swift
//  ios
//
//  Created by Jerry Jung on 06/08/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        CustomIndicatorView.shared.show()
    }
    
    // MARK: 인디케이터 숨김
    func dismissIndicator() {
        CustomIndicatorView.shared.dismiss()
    }
    
    // MARK: UILabel 줄바꿈 만들기
    func multipleLineOfTextLabel(_ textLabel: UILabel){
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
    }
    
    // MARK: 문자인증 로그인/회원가입 뷰를 띄움
    func presentLoginViewPopUp(){
        let presentLoginViewController = UIStoryboard(name: "LoginViewPopUp", bundle: Bundle.main)
        guard let popUP = presentLoginViewController.instantiateViewController(withIdentifier: "LoginViewPopUp") as? LoginViewPopUp else { return }
        
        popUP.modalPresentationStyle = .custom
        
        self.present(popUP,animated: true, completion: nil)
    }
    
    // MARK: 준비중 화면 팝업
    func commingSoonPopUp(){
        let presentCommingSoonPopUp = UIStoryboard(name: "CommingSoonPopUp", bundle: Bundle.main)
               guard let popUP = presentCommingSoonPopUp.instantiateViewController(withIdentifier: "CommingSoonPopUp") as? CommingSoonPopUp else { return }
               popUP.modalPresentationStyle = .custom
               self.present(popUP,animated: true, completion: nil)
    }
    
    // MARK: 로그인/회원가입 요구 화면 팝업
    func requireLoginPopUp(){
        let requireLoginPopUp = UIStoryboard(name: "RequireLoginPopUp", bundle: Bundle.main)
        guard let popUP = requireLoginPopUp.instantiateViewController(withIdentifier: "RequireLoginPopUp") as? RequireLoginPopUp else { return }
        popUP.modalPresentationStyle = .custom
        self.present(popUP,animated: true, completion: nil)
    }
}


