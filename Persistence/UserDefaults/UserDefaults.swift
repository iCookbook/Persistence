//
//  UserDefaults.swift
//  Expense
//
//  Created by Егор Бадмаев on 30.07.2022.
//

import Foundation
import Models

public extension UserDefaults {
    /// Contains array of user's favourite recipes.
    @UserDefaultCodable(key: "favouriteRecipes", defaultValue: [Models.Recipe]())
    static var favouriteRecipes: [Models.Recipe]
}
