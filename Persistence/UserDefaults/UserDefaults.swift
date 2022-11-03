//
//  UserDefaults.swift
//  Expense
//
//  Created by Егор Бадмаев on 30.07.2022.
//

import Foundation

public extension UserDefaults {
    /// Defines whether to show or not daily budget
    @UserDefault(key: "counter", defaultValue: 0)
    static var counter: Int
}
