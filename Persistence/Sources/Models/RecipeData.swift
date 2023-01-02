//
//  RecipeData.swift
//  Persistence
//
//  Created by Егор Бадмаев on 02.01.2023.
//

public struct RecipeData {
    let name: String
    let dateCreated: Date
    let numberOfServings: Int32
    let proteins: Double
    let fats: Double
    let carbohydrates: Double
    let calories: Double
    let cookingTime: Int32
    let comment: String?
    let ingredients: [String]?
    let imageData: Data?
    let steps: [StepData]?
}