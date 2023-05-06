//
//  LifePlusDemoApp.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

@main
struct LifePlusDemoApp: App {
    var body: some Scene {
        WindowGroup {
            
            let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
            
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
