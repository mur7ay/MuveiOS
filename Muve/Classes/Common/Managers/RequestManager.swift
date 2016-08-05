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
    
    typealias CompletionPath = [String: AnyObject]? -> ()
    
    static let sharedManager: RequestManager = {
        return RequestManager()
    }()
    
    func getPathBetweenLocations(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, completion: CompletionPath) {
        let urlString = "\(Urls.baseUrl)?origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&sensor=true&key=\(Maps.googleAPIKey)"
        let request = NSURLRequest(URL: NSURL(string: urlString)!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            guard let newResponse = response as? NSHTTPURLResponse else {
                debugPrint("failed \(response)")
                return
            }
            switch newResponse.statusCode {
            case 200:
                if let data = data {
                    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
                    if let json = json as? [String: AnyObject]{
                        completion(json)
                        return
                    }
                }
                completion(nil)
            default:
                completion(nil)
            }
        }
        task.resume()
    }
}