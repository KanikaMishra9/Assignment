//
//  CoreDataStack.swift
//  Assignment
//
//  Created by Kanika on 12/05/19.
//  Copyright © 2019 Kanika. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    let containerName = "Assignment"
    static let sharedManager = CoreDataStack()
    var persistentContainer: NSPersistentContainer!
    var managedObjectContext: NSManagedObjectContext!
    
    private override init() {
        super.init()
        getPersistentContainer()
        getManagedObjectContext()
    }
    
    // MARK: - Core Data stack
    
    func getPersistentContainer() {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getManagedObjectContext() {
        managedObjectContext = persistentContainer.viewContext
    }
}
