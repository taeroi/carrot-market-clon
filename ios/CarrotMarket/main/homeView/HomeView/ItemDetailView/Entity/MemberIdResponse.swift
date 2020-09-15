//
//  MemberIdResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/10.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct MemberIdResponse {
    var member_id : Int!
    var is_success: Bool!
    var code: Int!
    var message: String!
}
extension MemberIdResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        member_id <- map["member_id"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
}
