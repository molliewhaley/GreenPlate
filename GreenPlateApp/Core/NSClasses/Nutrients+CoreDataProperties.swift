//
//  Nutrients+CoreDataProperties.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//
//

import Foundation
import CoreData


extension Nutrients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nutrients> {
        return NSFetchRequest<Nutrients>(entityName: "Nutrients")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Int16
    @NSManaged public var units: String?
    @NSManaged public var recipe: Recipe?
    @NSManaged public var id: UUID? 
}

extension Nutrients {
    var unwrappedName: String {
        return name ?? ""
    }
    
    var unwrappedUnit: String {
        return units ?? "" 
    }
    
    var nutrientID: UUID {
        return id ?? UUID()
    }
}

extension Nutrients : Identifiable {

}
