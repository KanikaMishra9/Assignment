//
//  APIManager.swift
//  Assignment
//
//  Created by Kanika on 11/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    func apiGet(serviceName: String, parameters: [String: Any]?, completionHandler: @escaping (JSON?, NSError?) -> Void)
}

class APIManager: NSObject, APIManagerProtocol {
    
    func apiGet(serviceName: String, parameters: [String: Any]?, completionHandler: @escaping (JSON?, NSError?) -> Void) {
        
        request(serviceName, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    let json = JSON(data)
                    completionHandler(json, nil)
                }
            case .failure:
                completionHandler(nil, response.result.error as NSError?)
            }
        }
    }
    
}
