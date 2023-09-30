//
//  Instructions+CoreDataProperties.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//
//

import Foundation
import CoreData


extension Instructions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Instructions> {
        return NSFetchRequest<Instructions>(entityName: "Instructions")
    }

    @NSManaged public var instruction: String?
    @NSManaged public var step: Int16
    @NSManaged public var recipe: Recipe?
    @NSManaged public var id: UUID?
}

extension Instructions {
    var unwrappedInstructions: String {
        return instruction ?? ""
    }
    
    var instructionID: UUID {
        return id ?? UUID()
    }
}

extension Instructions : Identifiable {

}
