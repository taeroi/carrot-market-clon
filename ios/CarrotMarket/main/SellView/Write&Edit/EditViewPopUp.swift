//
//  EditViewPopUp.swift
//  ios
//
//  Created by 태로고침 on 2020/09/10.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

//
//  WriteViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/09/05.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

protocol ChangeCategoryBtnText2 {
    func changeCategory(_: String)
}
class EditViewPopUp: BaseViewController{
    
    @IBOutlet weak var tradingItemTitleTextField: UITextField!
    @IBOutlet weak var tradingItemPriceTextField: UITextField!
    @IBOutlet weak var tradingItemContentTextView: UITextView!
    
    //MARK: - TESTING
    @IBOutlet weak var categorySelectBtn: UIButton!
    
    //글자 수 체크 -> default: 0 / 0 글자이면 완료 버튼 클릭시 글자 입력 알람 팝업
    var titleTextCount = 0
    var priceTextCount = 0
    var contentTextCount = 0
    
    var categoryDelegate: ChangeCategoryBtnText2?
    
    // 닫기 버튼
    @IBAction func pressedDismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //완료 버튼
    @IBAction func pressedEditCompleteBtn(_ sender: UIButton) {
        checkTextCount()
    }
    
    
    // 품목 사진 업로드 버튼
    @IBAction func pressedUploadCameraBtn(_ sender: UIButton) {
        
    }
    
    // MARK: - 카테고리 선택 버튼 /CategoryView
    @IBAction func pressedSelectCategoryBtn(_ sender: UIButton) {
        
        // 카테고리 view controller 호출
        let categoryPopUp = UIStoryboard(name: "CategoryViewController", bundle: Bundle.main)
        guard let popUP = categoryPopUp.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController else { return }
        popUP.modalTransitionStyle = .coverVertical
        self.present(popUP,animated: true, completion: nil)
        
        popUP.prevViewController2 = self
        
        print("presenet category btn is pressed")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showKeyboard()
        hideKeyboardWhenTappedAround()
        
        tradingItemTitleTextField.delegate = self
        tradingItemPriceTextField.delegate = self
        tradingItemContentTextView.delegate = self
        designWriteViewPopUp()
        
        print("카테고리 -",(categorySelectBtn.titleLabel?.text)!)
        print("수정 게시글 ID: ",POST_ID)  
    }
    
    // 글 제대로 작성했는지 확인!
    func checkTextCount(){
        if titleTextCount == 0{
            presentAlert(title: "- 글 제목은 필수 입니당", message: "")
        }
        else if contentTextCount == 0 || contentTextCount < 30 {
            presentAlert(title: "- 글 내용은 필수 입니당(최소 30자)", message: "")
        }
            
        else if categorySelectBtn.titleLabel?.text == "카테고리 선택" {
            presentAlert(title: "- 카테고리 선택은 필수 입니당", message: "")
        }
        else{
            let title = tradingItemTitleTextField.text
            let category = CATEGORY
            guard let price = Int(tradingItemPriceTextField.text!) else { return  }
            let price_proposal = 1
            let content = tradingItemContentTextView.text
            let distance_id = 1
            let image_url = [""]
            
            ItemEditDataManager().editUsedItem(self, title!, category, price, price_proposal, content!, distance_id, image_url)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}


extension EditViewPopUp: UITextFieldDelegate,UITextViewDelegate{
    
    // 텍스트의 글자 체크
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == tradingItemTitleTextField{
            self.titleTextCount = textField.text?.count as! Int
            print("글 제목 글자 수 체크: ",titleTextCount)
            
        }
        else if textField == tradingItemPriceTextField{
            self.priceTextCount = textField.text?.count as! Int
            print("가격 글자 수 체크: ",priceTextCount)
        }
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.contentTextCount = textView.text.count
        print("글 내용 글자 수 체크: ",contentTextCount)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "올릴 게시글 내용을 작성해주세요. (가품 및 판매금지품목은 제한될 수 있어요.)" {
            textView.text = ""
        }
    }
    
    
    
    func showKeyboard() {
        // 판매품 제목
        tradingItemTitleTextField.becomeFirstResponder()
        
        //판매품 가격
        tradingItemPriceTextField.becomeFirstResponder()
        tradingItemPriceTextField.keyboardType = .numberPad
        
        //판매품 내용
        tradingItemContentTextView.becomeFirstResponder()
        tradingItemContentTextView.keyboardType = .alphabet
        
    }
    
    // 테두리 없앰
    func designWriteViewPopUp(){
        tradingItemTitleTextField.borderStyle = UITextField.BorderStyle.none
        tradingItemPriceTextField.borderStyle = UITextField.BorderStyle.none
    }
    
}
