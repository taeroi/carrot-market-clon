//
//  ItemPostResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/09.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

// 동네 검색 API Model
struct ItemPostResponse {
    
    var is_success: Bool!
    var code: Int!
    var message: String!
    
}

extension ItemPostResponse :Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]

    }
}





