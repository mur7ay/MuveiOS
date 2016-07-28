//
//  Array+Helper.swift
//  Muve
//
//  Created by Givi Pataridze on 28/07/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    mutating func removeObject(object: Element) {
        if let index = indexOf(object) {
            removeAtIndex(index)
        }
    }
}
