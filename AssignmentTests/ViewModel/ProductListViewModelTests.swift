//
//  ProductListViewModelTests.swift
//  AssignmentTests
//
//  Created by Kanika on 17/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Assignment

class ProductListViewModelTests: XCTestCase {
    
    let viewModel = ProductListViewModel()
    var coreDataManagerTest: CoreDataManagerTest!
    var apiManagerTest: APIManagerTest!
    var viewModelDelegate: ProductListViewModelTest!
    
    override func setUp() {
        coreDataManagerTest = CoreDataManagerTest()
        apiManagerTest = APIManagerTest()
        viewModel.coreDataManagder = coreDataManagerTest
        viewModel.apiManager = apiManagerTest
        viewModelDelegate = ProductListViewModelTest()
        viewModel.delegate = viewModelDelegate
    }
    
    override func tearDown() {
        coreDataManagerTest = nil
        apiManagerTest = nil
        viewModelDelegate = nil
        
    }
    
    func testGetProductListWithValidCount() {
        Constant.dataSource = .dataBase
        viewModel.products = []
        coreDataManagerTest.isEmptyResponse = false
        viewModel.getProductList()
        XCTAssertEqual(viewModel.products.count, 1)
    }
    
    func testGetProductListWithEmpty() {
        coreDataManagerTest.isEmptyResponse = true
        viewModel.getProductList()
        XCTAssertEqual(viewModel.products.count, 20)
    }
    
    func testGetProductListWithError() {
        apiManagerTest.isError = true
        coreDataManagerTest.isEmptyResponse = true
        viewModel.getProductList()
        XCTAssertEqual(viewModel.products.count, 0)
    }
    
    func testRefreshList() {
        coreDataManagerTest.isEmptyResponse = true
        viewModel.refreshList()
        XCTAssertEqual(viewModel.products.count, 20)
    }
    
}

class CoreDataManagerTest: CoreDataManagerProtocol {
    var isEmptyResponse: Bool = false
    func insertProducts(products: [Product]) {
        
    }
    
    func fetchProducts(offset: Int, limit: Int) -> [Product]? {
        if isEmptyResponse == true {
            return nil
        }
        let testRecord = mockRecordData()
        return [testRecord]
    }
    
    private func mockRecordData() -> Product {
        let aRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        return aRecord
    }
}

class APIManagerTest: APIManagerProtocol {
    
    var isError = false
    
    func apiGet(serviceName: String, parameters: [String: Any]?, completionHandler: @escaping (JSON?, NSError?) -> Void) {
        if isError == true {
            let error = NSError(domain: "", code: 101, userInfo: [NSLocalizedDescriptionKey: "Something went wrong!"])
            completionHandler(nil, error)
            
        } else {
            let bundel = Bundle(for: type(of: self))
            let path = bundel.path(forResource: "MockDeliveryData", ofType: "json")
            let data = NSData(contentsOfFile: path ?? "")
            if let data = data {
                let json = JSON(data: data as Data)
                completionHandler(json, nil)
            } else {
                completionHandler(nil, nil)
            }
        }
    }
    
}

class ProductListViewModelTest: ProductListViewModelDelegate {
   
    func refreshData() {
    }
    
    func errorOccured(errorMessage: String) {
    }
    
    func showMiddleLoader() {
    }
    
    func showBottomLoader() {
    }
    
    func hideTopLoader() {
    }
    
    func hideMiddleLoader() {
    }
    
    func hideBottomLoader() {
    }
    
}
