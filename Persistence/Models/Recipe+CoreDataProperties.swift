//
//  Recipe+CoreDataProperties.swift
//  Persistence
//
//  Created by Егор Бадмаев on 03.11.2022.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String
    @NSManaged public var dateCreated: Date
    @NSManaged public var numberOfServings: Int32
    @NSManaged public var proteins: Double
    @NSManaged public var fats: Double
    @NSManaged public var carbohydrates: Double
    @NSManaged public var calories: Double
    @NSManaged public var cookingTime: Int32
    @NSManaged public var comment: String?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var imageData: Data?
    @NSManaged public var steps: NSOrderedSet?

}

// MARK: Generated accessors for steps
extension Recipe {

    @objc(insertObject:inStepsAtIndex:)
    @NSManaged public func insertIntoSteps(_ value: Step, at idx: Int)

    @objc(removeObjectFromStepsAtIndex:)
    @NSManaged public func removeFromSteps(at idx: Int)

    @objc(insertSteps:atIndexes:)
    @NSManaged public func insertIntoSteps(_ values: [Step], at indexes: NSIndexSet)

    @objc(removeStepsAtIndexes:)
    @NSManaged public func removeFromSteps(at indexes: NSIndexSet)

    @objc(replaceObjectInStepsAtIndex:withObject:)
    @NSManaged public func replaceSteps(at idx: Int, with value: Step)

    @objc(replaceStepsAtIndexes:withSteps:)
    @NSManaged public func replaceSteps(at indexes: NSIndexSet, with values: [Step])

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: Step)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: Step)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSOrderedSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSOrderedSet)

}
