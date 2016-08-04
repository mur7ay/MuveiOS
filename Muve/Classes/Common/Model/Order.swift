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
    var images: [String]?
    var city: String?
    var clientEmail: String?
    
    ///Coordinates and location properties
    var departureCoordinate =  CLLocationCoordinate2D()
    var destinationCoordinate = CLLocationCoordinate2D()
    var distance: Double?
    
    ///Mover data
    var driver: String?
    var driverAlias: String?
    var car: String?
    
    ///Payment and prices
    var paymentMethod: String?
    var price: Int?
    
    ///Times and Dates
    var timestamp: Double?
    var finishTime: Double?
    var startTime: Double?
    var duration: String?
    
    
    ///Status
    var status: String?
    
    init?(_ map: Map) {
    }
    
    init(city: String, email: String, timestamp: Double, distance: Double, driver: String, payment: String, price: Int, startTime: Double, status: String, images: [String]) {
        self.city = city
        self.clientEmail = email
        self.timestamp = timestamp
        self.distance = distance
        self.driver = driver
        self.paymentMethod = payment
        self.price = price
        self.startTime = startTime
        self.status = status
        self.images = images
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
        
        images              <- map["orderImages"]
    }
    
    var creationDate: NSDate? {
        if let timestamp = timestamp {
            return NSDate(timeIntervalSince1970: timestamp)
        } else {
            return nil
        }
    }
    
    var priceFormatter: String {
        if let price = price {
            return "$" + String(price)
        } else {
            return "$0"
        }
    }
    
    var startTimeFormatter: String {
        guard let startTime = startTime else { return "" }
        return getDateStringWith1970(startTime)
    }
    
    var finishTimeFormatted: String {
        guard let finishTime = finishTime else { return "" }
        return getDateStringWith1970(finishTime)
    }
    
    private func getDateStringWith1970(interval: Double) -> String {
        let date = NSDate(timeIntervalSince1970: interval)
        return date.toString(.Custom("MM'/'dd'/'yy', 'hh':'mm' 'a"))!
    }
}



