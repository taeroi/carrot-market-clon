//
//  ItemPostDatamanager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/09.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//
import Alamofire
import AlamofireObjectMapper

class ItemPostDatamanager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK:-  상품 등록
    func postUsedItem(_ certificationViewController: WriteViewPopUp, _ title: String, _ category_id: Int, _ price: Int, _ price_proposal: Int, _ content: String, _ distance_id: Int, _ image_url: [ String]){
        
        //- header
        let head: HTTPHeaders = ["x-access-token" : "\(JWT)"]
        
        //- parameter
        let body: Parameters = ["title" : title,
                                "category_id" : category_id,
                                "price" : price,
                                "price_proposal": price_proposal,
                                "content" : content,
                                "distance_id": distance_id,
                                "image_url" : [ITEM_IMAGE]
                                ]
        //testing
        print("상품 등록 head: \(head)")
        print("상품 등록 Body: ", body)
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/post", method: .post, parameters: body, encoding: JSONEncoding.default, headers: head)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <ItemPostResponse>) in
                switch response.result {
                case .success(let itemPostResponse):
                    if itemPostResponse.code == 200 {
                        
                        print("\(itemPostResponse.message!)")
                        
                    } else {
                        print("인증 요청 실패")
                        
                    }
                case .failure(let error):
                    print("네트워크 연결 실패")
                    print(error.localizedDescription)
                }
            })
    }
    
    
}
