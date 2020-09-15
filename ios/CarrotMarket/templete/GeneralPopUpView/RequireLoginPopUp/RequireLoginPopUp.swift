//
//  RequireLoginPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.

import UIKit

//HomeViewController
class RequireLoginPopUp: BaseViewController {
    
    // MARK: - properties
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBAction func pressedPresentLoginViewBtn(_ sender: UIButton) {
        presentLoginViewPopUp()
    }
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        multipleLineOfTextLabel(infoLabel)
        designRequireLoginPopUpView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        dismiss(animated: false, completion: nil)
    }

}

// MARK: - 팝업 창 UI 편집
extension RequireLoginPopUp{
    
    func designRequireLoginPopUpView(){
        // 팝업뷰 테두리
        self.popUpView.layer.cornerRadius = 8

        // 로그인버튼 테두리
        self.loginBtn.layer.cornerRadius = 10
        
        self.cancelBtn.layer.cornerRadius = 8
        self.cancelBtn.layer.borderWidth = 0.5

        self.cancelBtn.layer.borderColor = UIColor.gray.cgColor
    }
}

