//
//  CoreDataManager.swift
//  Persistence
//
//  Created by Егор Бадмаев on 30.10.2022.
//

import CoreData

public protocol CoreDataManagerProtocol {
}

/// Responsible for CRUD operations with CoreData
public final class CoreDataManager: CoreDataManagerProtocol {
    
    // MARK: - Private Properties
    
    private let managedObjectContext: NSManagedObjectContext
    private let persistentContainer: NSPersistentContainer
    private let frameworkBundle: Bundle = Bundle(identifier: "com.egbad.Persistence") ?? .main
    
    // MARK: - Init
    
    /// Common init.
    public init(containerName: String) {
        guard let modelURL = frameworkBundle.url(forResource: containerName, withExtension: "momd") else {
            fatalError("Could not initialize url for framework's bundle")
        }
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Could not initialize NSManagedObjectModel in CDM initialization")
        }
        persistentContainer = NSPersistentContainer(name: containerName, managedObjectModel: model)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    
    /// Saves managed object contexts.
    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
