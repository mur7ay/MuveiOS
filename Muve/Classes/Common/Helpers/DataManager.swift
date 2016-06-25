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

//protocol DataManagerProtocol {
//    
//    func makeRequestWithoutMappingWithURL(URL: String, parameters: [String : AnyObject]?, completionHandler: DataResult<AnyObject, NSError> -> Void)
//    func makeRequestObjectWithURL<T: Mappable>(URL: String, parameters: [String : AnyObject]?, keyPath: String, completionHandler: DataResult<T, NSError>  -> Void)
//    func makeRequestWithURL<T: Mappable>(URL: String, parameters: [String : AnyObject]?, keyPath: String, completionHandler: DataResult<[T], NSError>  -> Void)
//    
//}

public class DataManager { //: DataManagerProtocol {
    
    static let sharedManager: DataManager = {
        return DataManager()
    }()
    
    let base: FIRDatabaseReference
    
    private init() {
        base = FIRDatabase.database().reference()
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
    
//    private func log<T>(response: Response<T, NSError>) {
//        DLog("Response: \(response.response.debugDescription)")
//        if let jsonString = jsonString(response.data!) {
//            DLog("JSON: \(jsonString)")
//        } else {
//            DLog("JSON: No data")
//        }
//    }
    
    private func jsonString(data: NSData) -> String? {
        return NSString(data: data, encoding: NSUTF8StringEncoding)! as String
    }

}

//func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
//    for (k, v) in right {
//        left.updateValue(v, forKey: k)
//    }
//}
//
//public struct DataResult<DataResponse, DataError: ErrorType> {
//    
//    public var result: DataResponse?
//    
//    public var error: DataError?
//    
//    public init(result: DataResponse?, error: DataError?) {
//        self.result = result
//        self.error = error
//    }
//    
//}
