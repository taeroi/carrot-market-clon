//
//  CategoryDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/08.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class CategoryDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: - 카테고리 API
    func getCategory(_ mainViewController: CategoryViewController){
        Alamofire
            .request("\(self.appDelegate.baseUrl)/categories", method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <CategoryResponse>) in
                switch response.result {
                case .success(let categoryResponse):
                    if categoryResponse.code == 200 {
                        print("\(categoryResponse.message!)")
                        
                        mainViewController.categories = categoryResponse.categories
                        print("category testing ",categoryResponse.categories!)
                        
                        mainViewController.categoryTableView.reloadData()
                        
                    } else {
                        print("동네 조회 실패")
                        
                    }
                case .failure:
                    print("네트워크 연결 실패")
                }
            })
    }
    
}
