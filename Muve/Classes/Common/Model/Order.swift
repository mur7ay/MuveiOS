//
//  Order.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import ObjectMapper

enum OrderStatus {
    case placed
    case delivered
    case pending
    case paid
}

enum ItemType {
    case furniture
    case homeDelivery
    case retailDelivery
    case charityDonation
}

struct Coordinate {
    var latitude: Float
    var longitude: Float
}

struct Order: Mappable {
    var uid: String?
    var images: [UIImage]?
    var city: String?
    var client: String?
    var timestamp: Double?
    var creationDate: NSDate? {
        if let timestamp = timestamp {
            return NSDate(timeIntervalSince1970: timestamp)
        } else {
            return nil
        }
    }
    var departureCoordinate: Coordinate?
    var destinationCoordinate: Coordinate?
    var distance: String?
    var driver: String?
    var driverAlias: String?
    var duration: String?
    var paymentMethod: String?
    var price: Int?
    var startTime: String?
    var status: String?
    
    init?(_ map: Map) {
    }
    
    init(uid: String) {
        self.uid = uid
    }
    
    mutating func mapping(map: Map) {
        uid                 <- map["orderId"]
        city                <- map["orderCity"]
        client              <- map["orderClient"]
        timestamp           <- map["orderCreationTime.timestamp"]
        distance            <- map["orderDistance"]
        driver              <- map["orderDriver"]
        driverAlias         <- map["orderDriverAlias"]
        duration            <- map["orderDuration"]
        paymentMethod       <- map["orderPaymentMethod"]
        price               <- map["orderPrice"]
        startTime           <- map["orderStartTimr.timestamp"]
        status              <- map["orderStatus"]
    }
}