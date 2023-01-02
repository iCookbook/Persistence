//
//  StepData.swift
//  Persistence
//
//  Created by Егор Бадмаев on 02.01.2023.
//

public struct StepData {
    let text: String
    let imageData: Data?
    
    public init(text: String, imageData: Data? = nil) {
        self.text = text
        self.imageData = imageData
    }
}
