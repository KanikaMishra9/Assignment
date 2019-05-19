//
//  CoreDataManager.swift
//  Assignment
//
//  Created by Kanika on 12/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    func insertProducts(products: [Product])
    func fetchProducts(offset: Int, limit: Int) -> [Product]?
}

class CoreDataManager: NSObject, CoreDataManagerProtocol {
    
    let entityName = "DeliveryProduct"
    let coreDataStack = CoreDataStack.sharedManager
    
    override init() {
        
    }
    
    init(container: NSPersistentContainer) {
        coreDataStack.persistentContainer = container
        coreDataStack.managedObjectContext = container.viewContext
    }
    
    func insertProducts(products: [Product]) {
        for product in products {
            if !checkProductExists(productID: Int64(product.id ?? 0)) {
                _ = addProduct(product: product)
            } else {
                _ = updateProduct(updatedProduct: product)
            }
        }
        coreDataStack.saveContext()
    }
    
    func addProduct(product: Product) -> DeliveryProduct? {
        if let productModel = NSEntityDescription.insertNewObject(forEntityName: entityName, into: coreDataStack.managedObjectContext) as? DeliveryProduct {
            productModel.id = Int64(product.id ?? 0)
            productModel.address = product.location?.address ?? ""
            productModel.detail = product.description ?? ""
            productModel.imageURL = product.imageURL ?? ""
            productModel.lattitude = product.location?.lattitude ?? 0
            productModel.longitude = product.location?.longitude ?? 0
            coreDataStack.saveContext()
            return productModel
        }
        return nil
    }
    
    func fetchProducts(offset: Int, limit: Int) -> [Product]? {
        var productList = [Product]()
        let fetchRequest: NSFetchRequest<DeliveryProduct> = DeliveryProduct.fetchRequest()
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        do {
            let products = try coreDataStack.managedObjectContext.fetch(fetchRequest)
            if !products.isEmpty {
                for product in products {
                    let aProduct = Product(product: product)
                    productList.append(aProduct)
                }
                return productList
            }
        } catch {
        }
        return nil
    }
    
    func removeProducts() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try coreDataStack.managedObjectContext.execute(deleteRequest)
        } catch _ as NSError {
        }
        coreDataStack.saveContext()
    }
    
    private func checkProductExists(productID: Int64) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %d", productID)
        var results = [DeliveryProduct]()
        do {
            if let result = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [DeliveryProduct] {
                results = result
            }
        } catch {
        }
        return !results.isEmpty
    }
    
    func getExistingProduct(productID: Int64) -> DeliveryProduct? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %d", productID)
        do {
            if let result = try coreDataStack.managedObjectContext.fetch(fetchRequest) as? [DeliveryProduct], result.isEmpty == false {
                return result[0]
            }
        } catch {
        }
        return nil
    }
    
    func updateProduct(updatedProduct: Product) -> Bool {
        if let deliveryProduct = getExistingProduct(productID: Int64(updatedProduct.id ?? 0)) {
            deliveryProduct.address = updatedProduct.location?.address ?? ""
            deliveryProduct.detail = updatedProduct.description ?? ""
            deliveryProduct.imageURL = updatedProduct.imageURL ?? ""
            deliveryProduct.lattitude = updatedProduct.location?.lattitude ?? 0
            deliveryProduct.longitude = updatedProduct.location?.longitude ?? 0
            coreDataStack.saveContext()
            return true
        }
        return false
    }
    
}
