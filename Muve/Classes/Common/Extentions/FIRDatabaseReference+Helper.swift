//
//  FIRDatabaseReference+Helper.swift
//  Muve
//
//  Created by Givi Pataridze on 25/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import Foundation
import Firebase

extension FIRDatabaseReference {
    func child(path: BaseStructure) -> FIRDatabaseReference {
        return child(path.str())
    }
}