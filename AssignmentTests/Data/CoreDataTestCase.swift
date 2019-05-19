//
//  CoreDataTestCase.swift
//  AssignmentTests
//
//  Created by Kanika on 15/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import XCTest
import CoreData
@testable import Assignment

class CoreDataTestCase: XCTestCase {
    
    let containerName = "Assignment"
    let entityName = "DeliveryProduct"
    var coreDataManager: CoreDataManager!
    let offset = 0
    let limit = 20
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: containerName, managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        if let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))]) {
            return managedObjectModel
        }
        return NSManagedObjectModel()
    }()
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager(container: mockPersistantContainer)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
    }
    
    private func mockRecordData() -> Product {
        let aRecord = Product(id: 0, address: "Mock Address", detail: "Mock Description", lattitude: 22.334, longitude: 123.39, imageURL: "Mock Url")
        return aRecord
    }
    
    func testInsertProduct() {
        let testRecord = mockRecordData()
        let deliveryProduct = coreDataManager.addProduct(product: testRecord)
        XCTAssertNotNil(deliveryProduct)
        XCTAssertEqual(testRecord.location?.address, deliveryProduct?.address)
    }
    
    func testFetchProducts() {
        let testRecord = mockRecordData()
        _ = coreDataManager.addProduct(product: testRecord)
        let products = coreDataManager.fetchProducts(offset: 0, limit: 20)
        XCTAssertEqual(products?.count, 1)
    }
    
    func testUpdateProductSuccess() {
        var testRecord = mockRecordData()
        _ = coreDataManager.addProduct(product: testRecord)
        testRecord.description = "Changed Description"
        _ = coreDataManager.updateProduct(updatedProduct: testRecord)
        let product = coreDataManager.getExistingProduct(productID: 0)
        XCTAssertEqual(testRecord.description, product?.detail)
    }
    
}
