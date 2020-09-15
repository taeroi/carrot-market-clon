//
//  SellViewPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/07.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class SellViewPopUp: BaseViewController{
    
    // 바탕으로 돌아가기 버튼
    @IBAction func pressedDismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // 중고 거래 글쓰기 버튼 - 중고 거래 창으로 이동
    @IBAction func pressedWriteViewPopUpBtn(_ sender: UIButton) {
        let ismember = ISMEMBER
        if ismember == 0{
            requireLoginPopUp()
        }else{
        writeViewPopUp()
        }
    }
    
    // 동네 생활 버튼
    @IBAction func pressedLifeViewPopUpBtn(_ sender: UIButton) {
        commingSoonPopUp()
    }
    // 동네 홍보 버튼
    @IBAction func pressedPromotionViewPopUpBtn(_ sender: UIButton) {
        commingSoonPopUp()
    }
    
    //중고 거래 글쓰기 창으로 이동
    func writeViewPopUp(){
        let writeViewPopUp = UIStoryboard(name: "WriteViewPopUp", bundle: Bundle.main)
        guard let popUP = writeViewPopUp.instantiateViewController(withIdentifier: "WriteViewPopUp") as? WriteViewPopUp else { return }
        popUP.modalPresentationStyle = .custom
        self.present(popUP,animated: true, completion: nil)
    }
}
