//
//  CertificationMessageResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/03.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct PhoneNumberResponse {
    var is_success: Bool!
    var code: Int!
    var message: String!
}
extension PhoneNumberResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
    
}


struct AuthenticationNumberResponse{
    var jwt: String!
    var is_signup: Int!
    var is_success: Bool!
    var code: Int!
    var message: String!
}
extension AuthenticationNumberResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        jwt <- map["jwt"]
        is_signup <- map["is_signup"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
    
}
