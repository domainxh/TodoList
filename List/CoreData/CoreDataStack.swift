//
//  DataManager.swift
//  List
//
//  Created by Xiaoheng Pan on 9/9/19.
//  Copyright © 2019 Xiaoheng Pan. All rights reserved.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ListModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading failed: \(error)")
            }
        }
        return container
    }()
    
}
