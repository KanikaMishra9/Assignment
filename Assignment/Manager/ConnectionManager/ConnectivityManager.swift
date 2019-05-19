//
//  ConnectivityManager.swift
//  Assignment
//
//  Created by Kanika on 11/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import UIKit
import Alamofire

class ConnectivityManager: NSObject {
    
    class func isConnectedToInternet() -> Bool {
        if let reachabilityManager = NetworkReachabilityManager() {
            return reachabilityManager.isReachable
        }
        return false
    }
    
}
