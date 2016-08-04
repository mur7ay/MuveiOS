//
//  RequestManager.swift
//  Muve
//
//  Created by Givi Pataridze on 04/08/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import CoreLocation

public class RequestManager {
    
    typealias CompletionPath = String? -> ()
    
    static let sharedManager: RequestManager = {
        return RequestManager()
    }()
    
    func getPathBetweenLocations(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion: CompletionPath) {
//            let params = "?event_id=" + event + "&racebag_hash=" + (hash ?? "")
//            if let url = NSURL(string: Constants.Urls.dealUrl + "/" + params) {
//                let request = NSURLRequest(URL: url)
//                let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//                let session = NSURLSession(configuration: config)
//                let task = session.dataTaskWithRequest(request) { (data, response, error) in
//                    guard let newResponse = response as? NSHTTPURLResponse else {
//                        debugPrint("failed \(response)")
//                        return
//                    }
//                    switch newResponse.statusCode {
//                    case 200:
//                        completion(self.serializeResponseToDeals(data), nil)
//                    default:
//                        completion(nil, error)
//                    }
//                }
//                task.resume()
//            }
    }
}