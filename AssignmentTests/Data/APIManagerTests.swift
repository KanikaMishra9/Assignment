//
//  APIManagerTests.swift
//  AssignmentTests
//
//  Created by Kanika on 16/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import XCTest
@testable import Assignment

class APIManagerTests: XCTestCase {
    
    let host = "mock-api-mobile.dev.lalamove.com"
    
    func testSuccessDeliveryData() {
        XCStub.request(withPathRegex: host, withResponseFile: "MockDeliveryData.json")
        let promise = expectation(description: "expected data from the json file")
        let urlStr = Constant.baseURL
        var params: [String: Any] = ["offset": 0]
        params["limit"] = 20
        
        APIManager().apiGet(serviceName: urlStr, parameters: params) { (json, error) in
            XCTAssertNotNil(json)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTAssertNotNil(error, "Webservice response returns with error")
            }
        }
    }
    
    func testFailureDeliveryData() {
        XCStub.request(withPathRegex: host, withResponseFile: "MockDeliveryData_Invalid.json")
        let promise = expectation(description: "expected error from the invalid json file")
        let urlStr = Constant.baseURL
        var params: [String: Any] = ["offset": 0]
        params["limit"] = 20
        
        APIManager().apiGet(serviceName: urlStr, parameters: params) { (json, error) in
            XCTAssertNotNil(error)
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                XCTAssertNotNil(error, "Webservice response returns with error")
            }
        }
    }
    
}
