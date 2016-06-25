//
//  Client.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import ObjectMapper

struct Client: Mappable {
    var uid: String!
    var name: String?
    var email: String?
    var city: String? //Easier to make enum for future
    var rating: Int?
    var ratingCount: Int?
    var reputation: Int?
    var phone: String?
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        uid             <- map["uid"]
        name            <- map["name"]
        email           <- map["email"]
        city            <- map["city"]
        rating          <- map["rating"]
        ratingCount     <- map["ratingCount"]
        reputation      <- map["reputation"]
        phone           <- map["tel"]
    }
}