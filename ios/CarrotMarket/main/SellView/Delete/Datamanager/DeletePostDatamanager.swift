//
//  DeletePostDatamanager.swift
//  ios
//
//  Created by 태로고침 on 2020/09/10.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper

class DeletePostDataManager: BaseViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var flag = 0
    //MARK: - 게시글 삭제 -> 성공했을시 1을 리턴
    func deletePostInfo(_ mainViewController: DeletePostPopUp, _ post_id: Int) -> Int {
        
        //testing 용으로 시행
        let head: HTTPHeaders = ["x-access-token":"\(JWT)"]
        
        Alamofire
            .request("\(self.appDelegate.baseUrl)/post/\(post_id)", method: .delete, encoding: JSONEncoding.default, headers: head)
            
            .validate()
            .responseObject(completionHandler: { (response: DataResponse <DeletePostResponse>) in
                switch response.result {
                case .success(let deletePostResponse):
                    if deletePostResponse.code == 200 {
                        print("\(deletePostResponse.message!)")
                        self.flag = 1
                        print("삭제 게시글 ID:", post_id)
                        
                    } else {
                         print("\(deletePostResponse.message!)")
                        self.flag = 0
                    }
                case .failure:
                    print("네트워크 연결 실패")
                    self.flag = 0
                }
            })
        return flag // 성공하면 flag = 1 을 반환
    }
   
}
