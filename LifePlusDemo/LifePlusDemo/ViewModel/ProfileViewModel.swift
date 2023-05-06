//
//  ProfileViewModel.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import Foundation
import CoreData

class ProfileViewModel: ObservableObject {
    
    
    private (set) var context: NSManagedObjectContext
    
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var phone: String = ""
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchUser(username: String) {
            let request = NSFetchRequest<Person>(entityName: "Person")
            request.predicate = NSPredicate(format: "username == %@", username)
            
            do {
                let result = try context.fetch(request)
                if let user = result.first {
                    self.name = user.name ?? ""
                    self.username = user.username ?? ""
                    self.phone = user.phone ?? ""
                }
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
}
