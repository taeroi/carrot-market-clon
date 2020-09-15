//
//  ItemDetailViewController.swift
//  ios
//
//  Created by 태로고침 on 2020/09/07.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import UIKit

class ItemDetailViewController: BaseViewController, UIViewControllerTransitioningDelegate{
    
    @IBOutlet weak var thumbnailImgBtn: UIButton! //대표 사진
    
    @IBOutlet weak var seller_img_btn: UIButton! //판매자 이미지
    @IBOutlet weak var seller_nickName_label: UILabel! //판매자 닉네임
    @IBOutlet weak var seller_address_label: UILabel! //판매자 주소
    
    @IBOutlet weak var itemTitleLabel: UILabel! //아이템 제목
    @IBOutlet weak var itemCategoryLabel: UILabel! //아이템 카테고리
    @IBOutlet weak var itemPostTime: UILabel! //아이템 게시 시간
    @IBOutlet weak var itemContent: UILabel! //아이템 내용
    
    
    @IBOutlet weak var chattingRecordLabel: UILabel! //채팅 수 - count
    @IBOutlet weak var lookUpRecordLabel: UILabel! // 관심 수 - count
    @IBOutlet weak var attentionRecordLabel: UILabel! // 조회 수 - count
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var chattingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setupSearchBarNavItems()
        chattingBtn.layer.cornerRadius = 7
        
        let postId = POST_ID
        
        //게시글 상세내역 API 연동
        ItemDetailDataManager().getPostItemDetail(self, postId)
        
        //내 ID API 연동
        MemberIdDataManger().getMemberId(self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
}

extension ItemDetailViewController:  UISearchBarDelegate,UISearchControllerDelegate {
    
    func setupSearchBarNavItems() {
        
        //쉐어 버튼
        let shareBtn = UIBarButtonItem(image: UIImage(named: "icon_share"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = shareBtn
        
        //메뉴 버튼
        let menuBtn = UIBarButtonItem(image: UIImage(named: "icon_report"), style: .plain, target: self, action: #selector(playTapped))
        
        self.navigationItem.rightBarButtonItem = menuBtn
        // 버튼 셋업
        navigationItem.rightBarButtonItems = [ menuBtn, shareBtn ]
        
    }
    
    
    @objc func playTapped(){
        
        //MARK: - 여기서 조건문 다른 판매자인지 내가 판매자인지 식별
        //게시글의 판매자가 자신일 경우
        if MY_ID == SELLER_ID{
            let optionMenu = UIAlertController(title: nil, message: "Choose the Level", preferredStyle: .actionSheet)
            let opt1 = UIAlertAction(title: "새로고침", style: .default, handler: nil)
            let opt2 = UIAlertAction(title: "끌어 올리기", style: .default, handler: nil)
            let editPost = UIAlertAction(title: "수정", style: .default, handler: self.editPost)
            let opt4 = UIAlertAction(title: "숨기기", style: .destructive, handler: nil)
            let deletePost = UIAlertAction(title: "삭제", style: .destructive, handler: self.deletePost)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
                
            optionMenu.addAction(opt1)
            optionMenu.addAction(opt2)
            optionMenu.addAction(editPost)
            optionMenu.addAction(opt4)
            optionMenu.addAction(deletePost)
            
            optionMenu.addAction(cancelAction)
            
            self.present(optionMenu, animated: true, completion: nil)
        }
            //게시글의 판매자가 자신이 아닐 경우
        else{
            let optionMenu = UIAlertController(title: nil, message: "Choose the Level", preferredStyle: .actionSheet)
            let opt1 = UIAlertAction(title: "새로고침", style: .default, handler: nil)
            let opt2 = UIAlertAction(title: "신고하기", style: .default, handler: nil)
            let opt3 = UIAlertAction(title: "이 사용자의 글 보지 않기", style: .default, handler: nil)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            
            optionMenu.addAction(opt1)
            optionMenu.addAction(opt2)
            optionMenu.addAction(opt3)
            
            optionMenu.addAction(cancelAction)
            
            self.present(optionMenu, animated: true, completion: nil)
        }
        
    }
    
    func editPost(alert: UIAlertAction!){
          print("게시글 수정하기로 이동합니다")
       let writeViewPopUp = UIStoryboard(name: "EditViewPopUp", bundle: Bundle.main)
        guard let popUP = writeViewPopUp.instantiateViewController(withIdentifier: "EditViewPopUp") as? EditViewPopUp else { return }
        popUP.modalPresentationStyle = .custom
        self.present(popUP,animated: true, completion: nil)
    }
    
    func deletePost(alert: UIAlertAction!){
       print("게시글 삭제하기로 이동합니다")
    
        let writeViewPopUp = UIStoryboard(name: "DeletePostPopUp", bundle: Bundle.main)
        guard let popUP = writeViewPopUp.instantiateViewController(withIdentifier: "DeletePostPopUp") as? DeletePostPopUp else { return }
        popUP.modalPresentationStyle = .custom
        self.present(popUP,animated: true, completion: nil)
    }
    
}
