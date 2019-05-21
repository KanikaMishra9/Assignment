//
//  ProductDetailVCTests.swift
//  AssignmentTests
//
//  Created by Kanika on 17/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import XCTest
@testable import Assignment

class ProductDetailVCTests: XCTestCase {
    
    let productDetailVC = ProductDetailVC()
    var detailViewModelTest: ProductDetailViewModel!
    
    override func setUp() {
        let product = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        detailViewModelTest = ProductDetailViewModel(product: product)
        
        productDetailVC.detailViewModel = detailViewModelTest
    }
    
    override func tearDown() {
    }
    
    func testDetailView() {
        productDetailVC.showProductdetail()
        XCTAssertNotNil(productDetailVC.mapView)
    }
    
    func testDeliveryViewSetUp() {
        productDetailVC.deliveryViewSetup()
        XCTAssertNotNil(productDetailVC.deliveryView)
    }
    
}
