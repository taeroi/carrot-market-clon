//
//  ViewItemList.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class ItemListDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getItemList(_ mainViewController: HomeViewController, _ neighborhood_setting_id: Int ) {
        Alamofire
            // 게시글 리스트 조회
            .request("\(self.appDelegate.baseUrl)/posts?neighborhood_setting_id=1", method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <ItemListResponse>) in
                switch response.result {
                case .success(let itemListResponse):
                    if itemListResponse.code == 200 {
                        print("\(itemListResponse.message!)")
                        
                        // 테이블의 itemList과 연결
                        mainViewController.itemList = itemListResponse.items
                        mainViewController.itemListTableView.reloadData()
                        
                        //print("ItemResponse testing: \(mainViewController.itemList)")
                        
                    } else {
                        print("조회 실패")
                        
                    }
                case .failure:
                    print("네트워크 연결 실패")
                }
            })
    }
}
