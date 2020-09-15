//
//  ItemListResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct ItemListResponse {
    var items: [Item]!
    var is_success: Bool!
    var code: Int!
    var message: String!
}

extension ItemListResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        items <- map["result"]
        is_success <- map["is_success"]
        code <- map["code"]
        message <- map["message"]
    }
}

struct Item{
    var id: Int!
    var title: String!
    var price: String!
    var post_status: Int!
    var member_distance_value: Int!
  //MARK: -
    var is_reupload: String!
    var post_time: String!
    var post_like_num: Int!
    var post_chatting_num: Int!
    var post_image_url: String!
    //MARK: -

    var address: String!
    var distance_difference: Double!
    var post_distance_value: Int!
}

extension Item: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        price <- map["price"]
        post_status <- map["post_status"]
        member_distance_value <- map["member_distance_value"]
        //MARK: -

        is_reupload <- map["is_reupload"]
        post_time <- map["post_time"]
        post_like_num <- map["post_like_num"]
        post_chatting_num <- map["post_chatting_num"]
        post_image_url <- map["post_image_url"]
        //MARK: -

        address <- map["address"]
        distance_difference <- map["distance_difference"]
        post_distance_value <- map["post_distance_value"]
        
    }
    
}
