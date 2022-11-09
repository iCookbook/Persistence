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
}
