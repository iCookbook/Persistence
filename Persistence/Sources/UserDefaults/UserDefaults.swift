//
//  UserDefaults.swift
//  Persistence
//
//  Created by Егор Бадмаев on 08.11.2022.
//

import Models

public extension UserDefaults {
    /// Contains array of user's favourite recipes.
    @UserDefaultCodable(key: "favouriteRecipes", defaultValue: [Models.Recipe]())
    static var favouriteRecipes: [Models.Recipe]
    
    /// Contains search requests history.
    @UserDefault(key: "searchRequestsHistory", defaultValue: [String]())
    static var searchRequestsHistory: [String]
    
    /// Defines whether user has already onboarded or not.
    @UserDefault(key: "hasOnboarded", defaultValue: false)
    static var hasOnboarded: Bool
    
    /// Contains search requests history.
    @UserDefault(key: "userAvatar")
    static var userAvatar: Data?
    
    /// Contains search requests history.
    @UserDefault(key: "userName")
    static var userName: String?
    
    /// Contains cuisines filters.
    @UserDefaultCodable(key: "cuisinesFilters", defaultValue: [Cuisine]())
    static var cuisinesFilters: [Cuisine]
    
    /// Contains diets filters.
    @UserDefaultCodable(key: "dietsFilters", defaultValue: [Diet]())
    static var dietsFilters: [Diet]
    
    /// Contains dishes filters.
    @UserDefaultCodable(key: "dishesFilters", defaultValue: [Dish]())
    static var dishesFilters: [Dish]
    
    /// Contains meals filters.
    @UserDefaultCodable(key: "mealsFilters", defaultValue: [Meal]())
    static var mealsFilters: [Meal]
}
