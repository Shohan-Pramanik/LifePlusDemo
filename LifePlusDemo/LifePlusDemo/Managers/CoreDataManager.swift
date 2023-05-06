//
//  CoreDataManager.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentStoreContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        persistentStoreContainer = NSPersistentContainer(name: "LifePlusDemo")
        persistentStoreContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
