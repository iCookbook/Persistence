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
        
    }
    
    func testCreatingRecipe() throws {
        
    }
    
    func testUpdatingRecipe() throws {
        
    }
    
    func testDeletingRecipe() throws {
        
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
