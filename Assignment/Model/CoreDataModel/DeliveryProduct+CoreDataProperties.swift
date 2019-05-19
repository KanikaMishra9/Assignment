//
//  DeliveryProduct+CoreDataProperties.swift
//  
//
//  Created by Kanika on 14/05/19.
//
//

import Foundation
import CoreData

extension DeliveryProduct {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DeliveryProduct> {
        return NSFetchRequest<DeliveryProduct>(entityName: "DeliveryProduct")
    }

    @NSManaged public var address: String?
    @NSManaged public var detail: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageURL: String?
    @NSManaged public var lattitude: Double
    @NSManaged public var longitude: Double

}
