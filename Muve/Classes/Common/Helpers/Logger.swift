//
//  Logger.swift
//  BusinessApps
//
//  Created by Виктор Заикин on 05.02.16.
//  Copyright © 2016 Виктор Заикин. All rights reserved.
//

import UIKit

func DLog(message:String, functionName:String = #function, fileName:String = #file)
{
    /***** Will only print in Debug mode. *****/
    
    /* For this to work, add the "-DDEBUG" flag to the "Swift Compiler - Custom Flags" to Debug mode, under Build Settings.  */
    #if DEBUG
        print("Logger: \(message)");
    #endif
}

