//
//  SetMemberProfileResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/04.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct SetMemberProfileResponse {
    var jwt : String!
    var is_profile_url: Int!    //사진등록: 0:미등록 1:등록
    var is_success: Bool!
    var code : Int!
    var message : String!
    
}
extension SetMemberProfileResponse: Mappable {
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        jwt <- map["jwt"]
        is_profile_url <- map["is_profile_url"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
    
}

