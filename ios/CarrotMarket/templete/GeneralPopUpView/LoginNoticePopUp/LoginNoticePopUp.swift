//
//  LoginNoticePopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/02.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

//HomeViewController
class LoginNoticePopUp: BaseViewController {
    
    // MARK: - properties
    @IBOutlet weak var uiJoinAndLoginBtn: UIButton!
    @IBOutlet weak var uiloginPopUpView: UIView!
    @IBOutlet weak var uiLoginBtn: UIButton!
    @IBOutlet weak var uiMyTownLabel: UILabel!
    
    
    var loginNoticePopUpDelegate: LoginNoticePopUpDelegate!
    
    override func viewDidLoad() {
        editLoginNoticePopUp()
        print("My TOWN: ",MYTOWN)
        uiMyTownLabel.text = MYTOWN
    }
    
    @IBAction func pressedHomeViewControllerButton(_ sender: UIButton) {
        self.loginNoticePopUpDelegate.pressedDismissButton()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pressedPresentLoginViewController(_ sender: UIButton) {
      presentLoginViewPopUp()
    }
}

// MARK: - 팝업 창 UI 편집
extension LoginNoticePopUp{
    
    func editLoginNoticePopUp(){
        // 팝업뷰 테두리
        self.uiloginPopUpView.layer.cornerRadius = 10

        // 로그인버튼 테두리
        self.uiLoginBtn.layer.cornerRadius = 10
        self.uiLoginBtn.layer.borderWidth = 1.0
        self.uiLoginBtn.layer.borderColor = UIColor.orange.cgColor
        
        self.uiJoinAndLoginBtn.layer.cornerRadius = 10
        
        
    }
}

