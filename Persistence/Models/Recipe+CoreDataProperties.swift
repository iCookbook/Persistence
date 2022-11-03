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

    @NSManaged public var name: String?

}
