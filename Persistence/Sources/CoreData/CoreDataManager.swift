//
//  CoreDataManager.swift
//  Persistence
//
//  Created by Егор Бадмаев on 30.10.2022.
//

import CoreData
import Models
import Logger

public typealias CoreDataManagerProtocol = CDRecipeProtocol & CDStepProtocol

public protocol CDRecipeProtocol {
    /// Fetches recipes from Core Data storage.
    ///
    /// - Returns: Array of recipes.
    func fetchRecipes() -> [Recipe]?
    
    /// Creates recipe with provided data.
    ///
    /// - Parameter data: The model with which we create a recipe.
    func createRecipe(with data: RecipeData)
    
    /// Updates provided recipe with provided data.
    ///
    /// - Parameters:
    ///   - recipe: Recipe to update.
    ///   - data: Data required for the update.
    func update(_ recipe: Recipe, with data: RecipeData)
    
    /// Deletes `Recipe`'s instance from Core Data.
    ///
    /// - Parameter recipe: recipe to be deleted from managed object context.
    func delete(_ recipe: Recipe)
}

public protocol CDStepProtocol {
    /// Creates step in provided recipe.
    ///
    /// - Parameters:
    ///   - data: Data required for creating the step.
    ///   - recipe: `Recipe` instance in which step will be added.
    func createStep(with data: StepData, for recipe: Recipe)
    
    /// Updates provided step with provided data.
    ///
    /// - Parameters:
    ///   - step: `Step` instance to update.
    ///   - data: Data required for the update.
    func update(_ step: Step, with data: StepData)
    
    /// Deletes `Step`'s instance from Core Data.
    ///
    /// - Parameter step: step to be deleted from managed object context.
    func delete(_ step: Step)
}

/// Responsible for CRUD operations with CoreData.
public final class CoreDataManager {
    
    /// An object space to manipulate and track changes to managed objects.
    let managedObjectContext: NSManagedObjectContext
    
    // MARK: - Private Properties
    
    /// A container that encapsulates the Core Data stack.
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
            createStep(with: $0, for: recipe)
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
    
    public func createRecipe(with data: RecipeData) {
        let recipe = Recipe(context: managedObjectContext)
        transferData(from: data, to: recipe)
        saveContext()
    }
    
    public func update(_ recipe: Recipe, with data: RecipeData) {
        transferData(from: data, to: recipe)
        saveContext()
    }
    
    public func delete(_ recipe: Recipe) {
        managedObjectContext.delete(recipe)
        saveContext()
    }
}

// MARK: - Step

extension CoreDataManager: CDStepProtocol {
    
    public func createStep(with data: StepData, for recipe: Recipe) {
        let step = Step(context: managedObjectContext)
        transferData(from: data, to: step)
        recipe.addToSteps(step)
        saveContext()
    }
    
    public func update(_ step: Step, with data: StepData) {
        transferData(from: data, to: step)
        saveContext()
    }
    
    public func delete(_ step: Step) {
        managedObjectContext.delete(step)
        saveContext()
    }
}
