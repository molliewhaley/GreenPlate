//
//  Recipe+CoreDataProperties.swift
//  GreenPlateApp
//
//  Created by Mollie Whaley on 8/22/23.
//
//

import Foundation
import CoreData


extension Recipe {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }
    
    @NSManaged public var image: String?
    @NSManaged public var servings: Int16
    @NSManaged public var time: Int16
    @NSManaged public var name: String?
    @NSManaged public var cuisine: String?
    @NSManaged public var dishType: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var instructions: NSSet?
    @NSManaged public var nutrients: NSSet?
    @NSManaged public var note: String?
    @NSManaged public var id: UUID?
    @NSManaged public var dateSaved: Date?
    @NSManaged public var isSaved: Bool
    
}

// MARK: Generated accessors for ingredients
extension Recipe {
    
    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingredients)
    
    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingredients)
    
    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)
    
    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)
    
}

// MARK: Generated accessors for instructions
extension Recipe {
    
    @objc(addInstructionsObject:)
    @NSManaged public func addToInstructions(_ value: Instructions)
    
    @objc(removeInstructionsObject:)
    @NSManaged public func removeFromInstructions(_ value: Instructions)
    
    @objc(addInstructions:)
    @NSManaged public func addToInstructions(_ values: NSSet)
    
    @objc(removeInstructions:)
    @NSManaged public func removeFromInstructions(_ values: NSSet)
    
}

// MARK: Generated accessors for nutrients
extension Recipe {
    
    @objc(addNutrientsObject:)
    @NSManaged public func addToNutrients(_ value: Nutrients)
    
    @objc(removeNutrientsObject:)
    @NSManaged public func removeFromNutrients(_ value: Nutrients)
    
    @objc(addNutrients:)
    @NSManaged public func addToNutrients(_ values: NSSet)
    
    @objc(removeNutrients:)
    @NSManaged public func removeFromNutrients(_ values: NSSet)
    
}

extension Recipe {
    var unwrappedName: String {
        return name ?? ""
    }
    
    var unwrappedImage: String {
        return image ?? ""
    }
    
    var unwrappedCuisine: String {
        return cuisine ?? ""
    }
    
    var unwrappedDish: String {
        return dishType ?? ""
    }
    
    var ingredientsArray: [Ingredients] {
        let sortedIngredients = Array(ingredients as? Set<Ingredients> ?? []).sorted { (ingredient1, ingredient2) in
            return ingredient1.unwrappedIngredient.localizedStandardCompare(ingredient2.unwrappedIngredient) == .orderedAscending
        }
        return sortedIngredients
    }
    
    var nutrientsArray: [Nutrients] {
        let sortedNutrients = Array(nutrients as? Set<Nutrients> ?? []).sorted { (nutrient1, nutrient2) in
            return nutrient1.unwrappedName.localizedCaseInsensitiveCompare(nutrient2.unwrappedName) == .orderedAscending
        }
        return sortedNutrients
    }
    
    var instructionsArray: [Instructions] {
        var instructions = Array(instructions as? Set<Instructions> ?? [])
        instructions.sort { $0.step < $1.step }
        return instructions
    }
    
    var unwrappedNote: String {
        return note ?? ""
    }
    
    var recipeID: UUID {
        return id ?? UUID()
    }
    
    var unwrappedDate: Date {
        return dateSaved ?? Date()
    }
}

extension Recipe : Identifiable {
    
}
