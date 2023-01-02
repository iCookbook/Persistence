//
//  CoreDataManager.swift
//  Persistence
//
//  Created by Егор Бадмаев on 30.10.2022.
//

import CoreData
import Logger

public typealias CoreDataManagerProtocol = CDRecipeProtocol & CDStepProtocol

public protocol CDRecipeProtocol {
    func fetchRecipes() -> [Recipe]?
    func create(with data: RecipeData)
    func update(_ recipe: Recipe, with data: RecipeData)
    func delete(recipe: Recipe)
}

public protocol CDStepProtocol {
    func create(with data: StepData, for recipe: Recipe)
    func update(_ step: Step, with data: StepData)
    func delete(step: Step)
}

/// Responsible for CRUD operations with CoreData.
public final class CoreDataManager {
    
    // MARK: - Private Properties
    
    private let managedObjectContext: NSManagedObjectContext
    private let persistentContainer: NSPersistentContainer
    
    // MARK: - Init
    
    /// Common init.
    public init(containerName: String) {
        guard let modelURL = Bundle(for: CoreDataManager.self).url(forResource: containerName, withExtension: "momd") else {
            fatalError("Could not initialize url for framework's bundle")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not initialize NSManagedObjectModel in CDM initialization")
        }
        persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: model)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Logger.log("Unresolved error \(error), \(error.userInfo)", logType: .error)
            }
        })
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    
    /// Initializes instance of Core Data manager for unit-testing.
    init() {
        guard let modelURL = Bundle(for: CoreDataManager.self).url(forResource: "Cookbook", withExtension: "momd") else {
            fatalError("Could not initialize url for framework's bundle")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not initialize NSManagedObjectModel in CDM initialization")
        }
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        persistentContainer = NSPersistentContainer(name: "Cookbook", managedObjectModel: model)
        persistentContainer.persistentStoreDescriptions = [persistentStoreDescription]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Private Methods
    
    /// Saves managed object contexts.
    private func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func transferData(from data: RecipeData, to recipe: Recipe) {
        recipe.name = data.name
        recipe.dateCreated = data.dateCreated
        recipe.numberOfServings = data.numberOfServings
        recipe.proteins = data.proteins
        recipe.fats = data.fats
        recipe.carbohydrates = data.carbohydrates
        recipe.calories = data.calories
        recipe.cookingTime = data.cookingTime
        recipe.comment = data.comment
        recipe.ingredients = data.ingredients
        recipe.imageData = data.imageData
        
        data.steps?.forEach {
            create(with: $0, for: recipe)
        }
    }
    
    private func transferData(from data: StepData, to step: Step) {
        step.text = data.text
        step.imageData = data.imageData
    }
}

// MARK: - Recipe

extension CoreDataManager: CDRecipeProtocol {
    
    public func fetchRecipes() -> [Recipe]? {
        try? managedObjectContext.fetch(Recipe.fetchRequest())
    }
    
    public func create(with data: RecipeData) {
        let recipe = Recipe(context: managedObjectContext)
        transferData(from: data, to: recipe)
        saveContext()
    }
    
    public func update(_ recipe: Recipe, with data: RecipeData) {
        transferData(from: data, to: recipe)
        saveContext()
    }
    
    public func delete(recipe: Recipe) {
        managedObjectContext.delete(recipe)
        saveContext()
    }
}

// MARK: - Step

extension CoreDataManager: CDStepProtocol {
    
    public func create(with data: StepData, for recipe: Recipe) {
        let step = Step(context: managedObjectContext)
        transferData(from: data, to: step)
        recipe.addToSteps(step)
        saveContext()
    }
    
    public func update(_ step: Step, with data: StepData) {
        transferData(from: data, to: step)
        saveContext()
    }
    
    public func delete(step: Step) {
        managedObjectContext.delete(step)
        saveContext()
    }
}
