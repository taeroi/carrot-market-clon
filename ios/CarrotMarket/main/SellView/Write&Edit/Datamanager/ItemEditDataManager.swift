//
//  ItemEditDataManager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/10.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class ItemEditDataManager {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

//MARK:-  상품 수정
   func editUsedItem(_ mainViewController: EditViewPopUp, _ title: String, _ category_id: Int, _ price: Int, _ price_proposal: Int, _ content: String, _ distance_id: Int, _ image_url: [ String]){

       //- header
        let head: HTTPHeaders = ["x-access-token" : "\(JWT)"]
       
       //- parameter
       let body: Parameters = ["title" : title,
                               "category_id" : category_id,
                               "price" : price,
                               "price_proposal": price_proposal,
                               "content" : content,
                               "distance_id": distance_id,
                               "image_url" : ""
                               ]
       //testing
       print("상품 수정 head: \(head)")
       print("상품 수정 Body: ", body)
        
       Alamofire
           .request("\(self.appDelegate.baseUrl)/post/\(POST_ID)", method: .patch, parameters: body, encoding: JSONEncoding.default, headers: head)
           .validate()
           .responseObject(completionHandler: { (response: DataResponse <ItemPostResponse>) in
               switch response.result {
               case .success(let itemPostResponse):
                   if itemPostResponse.code == 200 {

                       print("\(itemPostResponse.message!)")
                        print("수정한 게시글 ID: \(POST_ID)")
                    
                       
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
