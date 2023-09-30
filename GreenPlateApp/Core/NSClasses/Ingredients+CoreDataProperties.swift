//
//  Ingredients+CoreDataProperties.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//
//

import Foundation
import CoreData

extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients")
    }

    @NSManaged public var ingredient: String?
    @NSManaged public var recipe: Recipe?
    @NSManaged public var id: UUID? 
}

extension Ingredients {
    var unwrappedIngredient: String {
        return ingredient ?? ""
    }
    
    var ingredientID: UUID {
        return id ?? UUID()
    }
}

extension Ingredients : Identifiable {

}
