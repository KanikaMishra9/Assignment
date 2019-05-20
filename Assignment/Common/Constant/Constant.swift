//
//  Constant.swift
//  Assignment
//
//  Created by Kanika on 10/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    // MARK: Struct
    
    struct CellIdentifier {
        static let listCell = "ProductListCell"
    }
    
    struct Keys {
        static let googleAPIKey = "GOOGLE_API_KEY"
    }
    
    struct Endpoint {
        static let deliveries = "/deliveries"
    }
    
    struct ViewControllerTitle {
        static let listVCTitle = "Things to Deliver"
        static let detailVCTitle = "Delivery Details"
    }
    
    // MARK: Enum
    
    enum Dimension: CGFloat {
        case zeroSpacing = 0.0
        case spacing = 15.0
        case imageHieghtWidth = 70.0
        case deliveryDetailViewHeight = 100.0
        case height = 71.0
    }
    
    enum DataSource {
        case dataBase, server
    }
    
    // MARK: Stored Properties
    
    static let baseURL = "https://mock-api-mobile.dev.lalamove.com"
    static var dataSource = DataSource.dataBase
    static let fontSize: CGFloat = 14
    static let errorIcon = UIImage(named: "error_icon")

}
