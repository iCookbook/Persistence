//
//  CoreDataManagerTests.swift
//  Persistence-Unit-Tests
//
//  Created by Егор Бадмаев on 02.01.2023.
//

import XCTest
@testable import Persistence

class CoreDataManagerTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager()
    }
    
    override func tearDownWithError() throws {
        coreDataManager = nil
    }
    
    func testFetchingRecipe() throws {
        let recipes = coreDataManager.fetchRecipes()
        XCTAssertNotNil(recipes, "Returned value should not equals nil")
    }
    
    func testCreatingRecipe() throws {
        // Given
        let data = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataManager.managedObjectContext) { _ in
            return true
        }
        
        // When
        coreDataManager.createRecipe(with: data)
        
        // Then
        XCTAssertTrue((coreDataManager.fetchRecipes()?.count ?? 0) > 0)
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testUpdatingRecipe() throws {
        // Given
        let data = RecipeData(name: "Test 1", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        coreDataManager.createRecipe(with: data)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataManager.managedObjectContext) { _ in
            return true
        }
        
        // When
        let recipe = coreDataManager.fetchRecipes()?.first
        let newData = RecipeData(name: "Test 2", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        coreDataManager.update(recipe!, with: newData)
        
        // Then
        XCTAssertEqual(recipe?.name, newData.name)
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testDeletingRecipe() throws {
        let data = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        coreDataManager.createRecipe(with: data)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataManager.managedObjectContext) { _ in
            return true
        }
        
        let recipe = coreDataManager.fetchRecipes()?.first
        coreDataManager.delete(recipe!)
        
        let recipes = coreDataManager.fetchRecipes()
        XCTAssertNotNil(recipes)
        XCTAssertEqual(recipes?.count, 0)
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testCreatingStep() throws {
        let recipeData = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        coreDataManager.createRecipe(with: recipeData)
        let recipe = coreDataManager.fetchRecipes()?.first
        
        let stepData = StepData(text: "Step text")
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataManager.managedObjectContext) { _ in
            return true
        }
        
        coreDataManager.createStep(with: stepData, for: recipe!)
        
        XCTAssertNotNil(recipe!.steps)
        XCTAssertEqual(recipe!.steps?.count, 1)
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testUpdatingStep() throws {
        // Given
        let recipeData = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        coreDataManager.createRecipe(with: recipeData)
        let recipe = coreDataManager.fetchRecipes()?.first
        let stepData = StepData(text: "Step text")
        
        coreDataManager.createStep(with: stepData, for: recipe!)
        let step = recipe?.steps?.firstObject as! Step
        let newData = StepData(text: "Step text 2", imageData: Data())
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataManager.managedObjectContext) { _ in
            return true
        }
        
        // When
        coreDataManager.update(step, with: newData)
        
        // Then
        XCTAssertNotEqual(step.text, stepData.text)
        XCTAssertEqual(step.text, newData.text)
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testDeletingStep() throws {
        let recipeData = RecipeData(name: "Test", dateCreated: Date(), numberOfServings: 1, proteins: 0.0, fats: 0.0, carbohydrates: 0.0, calories: 0.0, cookingTime: 1, comment: nil, ingredients: nil, imageData: nil, steps: nil)
        coreDataManager.createRecipe(with: recipeData)
        let recipe = coreDataManager.fetchRecipes()?.first
        let stepData = StepData(text: "Step text")
        
        coreDataManager.createStep(with: stepData, for: recipe!)
        let step = recipe?.steps?.firstObject as! Step
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataManager.managedObjectContext) { _ in
            return true
        }
        
        coreDataManager.delete(step)
        
        XCTAssertEqual(recipe?.steps?.count, 0)
        waitForExpectations(timeout: 3.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
}
