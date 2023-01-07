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
        XCTAssertEqual(UserDefaults.favouriteRecipes, [Models.Recipe](), "Favourite recipes should equal empty array by default.")
        XCTAssertEqual(UserDefaults.cuisinesFilters, [Cuisine](), "Cuisine filters should equal empty array by default.")
        XCTAssertEqual(UserDefaults.dietsFilters, [Diet](), "Diet filters should equal empty array by default.")
        XCTAssertEqual(UserDefaults.dishesFilters, [Dish](), "Dish filters should equal empty array by default.")
        XCTAssertEqual(UserDefaults.mealsFilters, [Meal](), "Meal filters should equal empty array by default.")
    }
}
