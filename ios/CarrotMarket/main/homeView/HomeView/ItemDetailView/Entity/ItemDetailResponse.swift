//
//  ItemDetailEntity.swift
//  ios
//
//  Created by 태로고침 on 2020/09/08.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct ItemDetailEntityResponse {
    var itemInfo : [ItemInfo]!
    var is_success: Bool!
    var code: Int!
    var message: String!
    
}
extension ItemDetailEntityResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        itemInfo <- map["result"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
}

struct ItemInfo{
    var seller_id: Int!
    var nick_name: String!
    var manner_temperature: String!
    var address: String!
    var post_id: Int!
    
    var title: String!
    var name: String!
    var post_status: Int!
    var chatting_id: Int!
    var is_reupload: String!
    
    var post_time: String!
    var content: String!
    var post_like_num: Int!
    var post_chatting_num: Int!
    var view_count: Int!
    
    var like_on: Int!
    var price: String!
    var price_proposal: Int!
    
}

extension ItemInfo: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        seller_id <- map["seller_id"]
        nick_name <- map["nick_name"]
        manner_temperature <- map["manner_temperature"]
        address <- map["address"]
        post_id <- map["post_id"]
        
        title <- map["title"]
        name <- map["name"]
        post_status <- map["post_status"]
        chatting_id <- map["chatting_id"]
        is_reupload <- map["is_reupload"]
        
        post_time <- map["post_time"]
        content <- map["content"]
        post_like_num <- map["post_like_num"]
        post_chatting_num <- map["post_chatting_num"]
        view_count <- map["view_count"]
        
        like_on <- map["like_on"]
        price <- map["price"]
        price_proposal <- map["price_proposal"]

    }
}



