//
//  DeletePostPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/10.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class DeletePostPopUp: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedCancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pressedDeleteBtn(_ sender: UIButton) { //id: 게시물 아이디
        presentAlert(title: "삭제되었습니다.", message: "")
        if DeletePostDataManager().deletePostInfo(self,POST_ID) == 1 {
            dismiss(animated: true, completion: nil)
        }
    }
}
