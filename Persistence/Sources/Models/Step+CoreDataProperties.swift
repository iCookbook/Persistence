//
//  Step+CoreDataProperties.swift
//  Persistence
//
//  Created by Егор Бадмаев on 02.01.2023.
//
//

import Foundation
import CoreData


extension Step {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Step> {
        return NSFetchRequest<Step>(entityName: "Step")
    }

    @NSManaged public var text: String
    @NSManaged public var imageData: Data?
    @NSManaged public var recipe: Recipe

}
