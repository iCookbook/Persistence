//
//  UserDefaultsTests.swift
//  Persistence-Unit-Tests
//
//  Created by Егор Бадмаев on 03.01.2023.
//

import XCTest
@testable import Models

class UserDefaultsTests: XCTestCase {
    
    func testUserDefault() throws {
        XCTAssertEqual(UserDefaults.searchRequestsHistory, [String](), "Search requests history should equal empty array by default.")
    }
    
    func testDefaultNilUserDefault() throws {
        UserDefaults.userAvatar = nil
        UserDefaults.userName = nil
        
        XCTAssertNil(UserDefaults.userAvatar, "User avatar property should allow to contain nil.")
        XCTAssertNil(UserDefaults.userName, "User name property should allow to contain nil.")
    }
    
    func testCodableUserDefault() throws {
        XCTAssertNotNil(UserDefaults.favouriteRecipes, "Favourite recipes should not equal nil.")
        XCTAssertNotNil(UserDefaults.cuisinesFilters, "Cuisine filters should not equal nil.")
        XCTAssertNotNil(UserDefaults.dietsFilters, "Diet filters should not equal nil.")
        XCTAssertNotNil(UserDefaults.dishesFilters, "Dish filters should not equal nil.")
        XCTAssertNotNil(UserDefaults.mealsFilters, "Meal filters should not equal nil.")
    }
}
