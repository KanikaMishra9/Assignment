//
//  ProductListVCTests.swift
//  AssignmentTests
//
//  Created by Kanika on 17/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import XCTest
@testable import Assignment

class ProductListVCTests: XCTestCase {
    let productListVC = ProductListVC()
    
    override func setUp() {
        let tableView = productListVC.listTableView
        tableView.register(ProductListCell.self, forCellReuseIdentifier: Constant.CellIdentifier.listCell)
    }
    
    override func tearDown() {
    }
    
    func testTableViewDelegate() {
        XCTAssertTrue(productListVC.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewDataSource() {
        XCTAssertTrue(productListVC.conforms(to: UITableViewDataSource.self))
    }
    
    func testConfigureCell() {
        let aRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        productListVC.productListViewModel.products.append(aRecord)
        let tableView = productListVC.listTableView
        let cell = productListVC.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testNumberOfRowsInSection() {
        let tableView = productListVC.listTableView
        XCTAssertNotNil(productListVC.tableView(tableView, numberOfRowsInSection: 0))
    }
    
}
