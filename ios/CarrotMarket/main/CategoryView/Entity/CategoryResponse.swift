//
//  CategoryResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/08.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct CategoryResponse{
    var categories: [Category]!
    var is_success: Bool!
    var code: Int!
    var message: String!
}
extension CategoryResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        categories <- map["result"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
}




struct Category {
    var id: Int!
    var name: String!
}
extension Category: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
