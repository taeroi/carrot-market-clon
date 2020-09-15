//
//  ItemDetailDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/08.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper


class ItemDetailDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 동네 인증하기 API - no.11
    func getPostItemDetail(_ mainViewController: ItemDetailViewController, _ post_id: Int) {
        
        //testing 용으로 시행
        let head: HTTPHeaders = ["x-access-token":"\(JWT)"]
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/post/\(post_id)", method: .get, encoding: JSONEncoding.default, headers: head)
            
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <ItemDetailEntityResponse>) in
                switch response.result {
                case .success(let itemDetailEntityResponse):
                    if itemDetailEntityResponse.code == 200 {
                        print("\(itemDetailEntityResponse.message!)")
                        
                        SELLER_ID = itemDetailEntityResponse.itemInfo[0].seller_id
                        print("Seller ID: \(itemDetailEntityResponse.itemInfo[0].seller_id!)")
                        print("게시물 ID: \(post_id)")
                        
                        mainViewController.seller_nickName_label.text = itemDetailEntityResponse.itemInfo[0].nick_name!
                        mainViewController.seller_address_label.text = itemDetailEntityResponse.itemInfo[0].address!
                        mainViewController.itemTitleLabel.text = itemDetailEntityResponse.itemInfo[0].title!
                        mainViewController.itemCategoryLabel.text = itemDetailEntityResponse.itemInfo[0].name!
                        mainViewController.itemPostTime.text = itemDetailEntityResponse.itemInfo[0].post_time
                        
                        mainViewController.itemContent.text = itemDetailEntityResponse.itemInfo[0].content!
                        mainViewController.chattingRecordLabel.text = "\((itemDetailEntityResponse.itemInfo[0].post_chatting_num)!)"
                        mainViewController.lookUpRecordLabel.text = "\((itemDetailEntityResponse.itemInfo[0].view_count)!)"
                        mainViewController.attentionRecordLabel.text = "\((itemDetailEntityResponse.itemInfo[0].like_on)!)"
                        mainViewController.itemPriceLabel.text = itemDetailEntityResponse.itemInfo[0].price!
                       
                     
                    } else {
                        print("\(itemDetailEntityResponse.message!)")
                        
                    }
                case .failure(let error):
                    print(error, " 네트워크 연결 실패")
                }
            })
    }
    
}

