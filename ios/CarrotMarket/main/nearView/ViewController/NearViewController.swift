//
//  test2.swift
//  ios
//
//  Created by 태로고침 on 2020/08/30.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

//MARK: -  우리 동네 이건 어떠세요? view 카테고리 <- 연동하여 정리
// 내 근처 이런 가게도 있어요 view -> collection view 이용하여 별도 가게 홍보란 만들어서 API 연동하기
// collection view cell에서 동네명, 이미지 버튼 크기, 레이블 버튼 길이<자동줄바꿈>, 판매자 API 연동하기

// 가게 소개 전체보기 view -> 클릭하면 홍보하는 가게 나오게 API 연동하여 파싱

class NearViewController: BaseViewController {
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var townNameLabel: UILabel!
    
    @IBOutlet weak var serachTextField: UITextField!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    
    @IBOutlet weak var viewAllStoresBtn: UIButton!
    @IBOutlet weak var enrollStoreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      settingDesign()
        userIDLabel.text = USER_NICKNAME
        townNameLabel.text = MYTOWN
    }
    
    func settingDesign(){
        serachTextField.layer.cornerRadius = 3
        btn1.layer.cornerRadius = 20
        btn2.layer.cornerRadius = 20
        btn3.layer.cornerRadius = 20
        btn4.layer.cornerRadius = 20
        btn5.layer.cornerRadius = 20
        
        btn6.layer.cornerRadius = 20
        btn7.layer.cornerRadius = 20
        btn8.layer.cornerRadius = 20
        btn9.layer.cornerRadius = 20
        
        viewAllStoresBtn.layer.borderWidth = 1.0
        viewAllStoresBtn.layer.borderColor = UIColor.lightGray.cgColor
        viewAllStoresBtn.layer.cornerRadius = 5
    
        enrollStoreBtn.layer.borderWidth = 1.0
        enrollStoreBtn.layer.cornerRadius = 5
        
    }
  
}
