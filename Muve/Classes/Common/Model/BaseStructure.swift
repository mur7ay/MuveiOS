//
//  BaseStructure.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation

enum BaseStructure {
    case clientUidMappings
    case handUidMappings
    case helperUidMappings
    
    case clients
    case hands
    case helpers
    
    func str() -> String {
        return "\(self)"
    }
}