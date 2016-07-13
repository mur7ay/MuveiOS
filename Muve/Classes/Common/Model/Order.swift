//
//  Order.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

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

struct Order: Mappable {
    var uid: String?
    var email: String?
    var images: [UIImage]?
    var city: String?
    var clientEmail: String?
    var timestamp: Double?
    var creationDate: NSDate? {
        if let timestamp = timestamp {
            return NSDate(timeIntervalSince1970: timestamp)
        } else {
            return nil
        }
    }
    var departureCoordinate =  CLLocationCoordinate2D()
    var destinationCoordinate = CLLocationCoordinate2D()
    var distance: Double?
    var driver: String?
    var driverAlias: String?
    var duration: String?
    var paymentMethod: String?
    var price: Int?
    var startTime: Double?
    var status: String?
    
    init?(_ map: Map) {
    }
    
    init() {
    }
    
    init(city: String, email: String, timestamp: Double, distance: Double, driver: String, payment: String, price: Int, startTime: Double, status: String) {
        self.city = city
        self.clientEmail = email
        self.timestamp = timestamp
        self.distance = distance
        self.driver = driver
        self.paymentMethod = payment
        self.price = price
        self.startTime = startTime
        self.status = status
    }
    
    mutating func mapping(map: Map) {
        uid                 <- map["orderId"]
        city                <- map["orderCity"]
        clientEmail         <- map["orderClient"]
        timestamp           <- map["orderCreationTime.timestamp"]
        distance            <- map["orderDistance"]
        driver              <- map["orderDriver"]
        driverAlias         <- map["orderDriverAlias"]
        duration            <- map["orderDuration"]
        paymentMethod       <- map["orderPaymentMethod"]
        price               <- map["orderPrice"]
        startTime           <- map["orderStartTimr.timestamp"]
        status              <- map["orderStatus"]
        
        departureCoordinate.latitude    <- map["orderDepartureLat"]
        departureCoordinate.longitude   <- map["orderDepartureLng"]
        destinationCoordinate.latitude  <- map["orderDestinationLat"]
        destinationCoordinate.longitude <- map["orderDestinationLng"]
    }
}