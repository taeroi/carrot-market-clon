//
//  SearchNeighborhoodResponse.swift
//  ios
//
//  Created by 태로고침 on 2020/09/06.
//  Copyright © 2020 Jerry Jung. All rights reserved.

import ObjectMapper

// 동네 검색 API Model
struct SearchNeighborhoodResponse{
    var code: Int!
    var message: String!
    var is_success: Bool!
    var neighborhoodInfo: [NeighborhoodInfo]!
}

extension SearchNeighborhoodResponse{
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        is_success <- map["is_success"]
        neighborhoodInfo <- map["result"]
    }
}

struct NeighborhoodInfo {
    var id: Int!
    var name: String!
}
extension NeighborhoodInfo{
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
    
    
   
