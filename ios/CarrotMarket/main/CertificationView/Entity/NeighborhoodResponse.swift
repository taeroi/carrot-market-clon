//
//  TutorialResponse.swift
//  ios
//
//  Created by Jerry Jung on 13/08/2019.
//  Copyright © 2019 Jerry Jung. All rights reserved.
//

import ObjectMapper

struct NeighborhoodResponse {
    var code: Int!
    var message: String!
    var is_success: Bool!
    var neighborhoods: [Neighborhood]!    
}

extension NeighborhoodResponse: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
        is_success <- map["is_success"]
        neighborhoods <- map["result"]
    }
}

struct Neighborhood{
    var id: Int!
    var name: String!
    var distance: Float!
}

extension Neighborhood: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        distance <- map["distance"]
    }
    
}
