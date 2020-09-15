//
//  authenticateTownEntity.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct AuthenticateTownResponse {
    var is_success : Bool!
    var code: Int!
    var message: String!
    
}

extension AuthenticateTownResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
    
}