//
//  EnrollNeighborhoodTownResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

//동네 등록 설정 API Model
struct EnrollNeighborhoodTownResponse{
    var id: Int!
    var is_success: Bool!
    var code: Int!
    var message: String!
    var neighborhood_setting_id: Int! // 이 값을 JWT 처럼 사용
}

extension EnrollNeighborhoodTownResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
        neighborhood_setting_id <- map["neighborhood_setting_id"]
    }
    
}

