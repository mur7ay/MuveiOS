//
//  FeedCollectionViewCell.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import GoogleMaps

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblTransportType: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewMap: GMSMapView!
    
    var order: Order! {
        didSet {
           cellInit()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func cellInit() {
        guard let _ = order else { return }
        lblTransportType.text = order.car ?? "Ford F-350"
        lblDateTime.text = order.startTimeFormatter
        lblPrice.text = order.priceFormatter
        renderMap()
    }
    
    private func renderMap() {
        let from = order.departureCoordinate
        let to = order.destinationCoordinate
        RequestManager.sharedManager.getPathBetweenLocations(from, to: to) { path in
            if let path = path {
                guard let routes = path["routes"] as? [AnyObject] else { return }
                guard let overviewLine = routes.first?["overview_polyline"] as? [String: AnyObject] else { return }
                guard let points = overviewLine["points"] as? String else { return }
                dispatch_async(dispatch_get_main_queue(), { 
                    let pathGoogle = GMSPath.init(fromEncodedPath: points)
                    let line = GMSPolyline.init(path: pathGoogle)
                    line.strokeColor = .redColor()
                    line.strokeWidth = 3
                    line.map = self.viewMap
                    self.viewMap.camera = GMSCameraPosition.cameraWithTarget(from, zoom: 8)
                })
                
            }
        }
    }
}
