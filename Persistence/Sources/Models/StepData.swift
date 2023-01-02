//
//  StepData.swift
//  Persistence
//
//  Created by Егор Бадмаев on 02.01.2023.
//

/// Represents `Step: NSManagedObject` class to simplify initializing and providing data to interactor.
public struct StepData {
    /// Step's text/description.
    let text: String
    /// Raw data for image.
    let imageData: Data?
    
    /// Memberwise initializer with optional `imageData` property.
    public init(text: String, imageData: Data? = nil) {
        self.text = text
        self.imageData = imageData
    }
}
