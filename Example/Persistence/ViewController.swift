//
//  ViewController.swift
//  Persistence
//
//  Created by htmlprogrammist on 11/03/2022.
//  Copyright (c) 2022 htmlprogrammist. All rights reserved.
//

import UIKit
import Persistence

class ViewController: UIViewController {
    
    private lazy var coreDataManager: CoreDataManagerProtocol = CoreDataManager(containerName: "Cookbook")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(coreDataManager.self)
        
//        let recipes: [Recipe] = coreDataManager.fetchRecipes() ?? []
//        print(recipes)
//        for recipe in recipes {
//            coreDataManager.delete(recipe: recipe)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(UserDefaults.counter)
        UserDefaults.counter += 1
    }
}
