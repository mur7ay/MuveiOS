//
//  Hand.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import ObjectMapper

struct Hand: Mappable {
    var uid: String!
    var name: String?
    var email: String?
    var city: String? //Easier to make enum for future
    var rating: Int?
    var ratingCount: Int?
    var reputation: Int?
    var phone: String?
    var address: String?
    var zip: String?
    var approved: Bool?
    var canLift: Bool?
    var dateOfBirth: String?
    var hasCheckingAccount: Bool?
    var latitude: Double?
    var longitude: Double?
    var state: String?
    var status: String?
    
    init?(_ map: Map) {
    }
    
    mutating func mapping(map: Map) {
        uid                     <- map["uid"]
        name                    <- map["name"]
        email                   <- map["email"]
        city                    <- map["city"]
        rating                  <- map["rating"]
        ratingCount             <- map["ratingCount"]
        reputation              <- map["reputation"]
        phone                   <- map["phone"]
        zip                     <- map["zip"]
        address                 <- map["address"]
        approved                <- map["approved"]
        canLift                 <- map["canLift"]
        dateOfBirth             <- map["dateOfBirth"]
        hasCheckingAccount      <- map["hasCheckingAccount"]
        latitude                <- map["lat"]
        longitude               <- map["lng"]
        state                   <- map["state"]
        status                  <- map["status"]
    }
}