//
//  DataManager.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import ObjectMapper
import Firebase

public class DataManager {
    
    static let sharedManager: DataManager = {
        return DataManager()
    }()
    
    let base: FIRDatabaseReference
    let storage: FIRStorageReference
    
    private init() {
        base = FIRDatabase.database().reference()
        storage = FIRStorage.storage().referenceForURL(Firebase.storageUrl)
        
        #if DEBUG
            FIRDatabase.setLoggingEnabled(true)
        #else
            FIRDatabase.setLoggingEnabled(false)
        #endif
    }
    
    func disconnect() {
        FIRDatabase.database().goOffline()
    }
    
    func connect() {
        FIRDatabase.database().goOnline()
    }
    
    func putImage() {
        
    }
    
    private func jsonString(data: NSData) -> String? {
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }
    
    func createOrder(order: Order, completion: Completion) {
        guard let userMailKey = LoginHelper.userEmailAsId() else { return }
        let key = base.child("activeClientOrders/\(userMailKey)").childByAutoId().key
        var orderWithId = order
        orderWithId.uid = key
        let childUpdates = ["activeClientOrders/\(userMailKey)/\(key)": Mapper().toJSON(orderWithId)]
        base.updateChildValues(childUpdates)
    }

}
