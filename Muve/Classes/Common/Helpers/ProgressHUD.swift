//
//  ProgressHUD.swift
//  Muve
//
//  Created by Givi Pataridze on 22/06/16.
//  Copyright © 2016 Muve. All rights reserved.
//

import UIKit
import KRProgressHUD

public class ProgressHUD {
    static func show() {
        KRProgressHUD.show(progressHUDStyle: .WhiteColor, maskType: .Clear, activityIndicatorStyle: .Color(Colors.muveRed, Colors.loginButtonPressed))
    }
    static func hide() {
        KRProgressHUD.dismiss()
    }
}