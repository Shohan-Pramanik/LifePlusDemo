//
//  LoginViewModel.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    private (set) var context: NSManagedObjectContext
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginButtonClicked: Bool = false
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func validateLoginData(username: String, password: String) async -> Bool{
        let request = NSFetchRequest<Person>(entityName: "Person")
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let matchingRegistrations = try context.fetch(request)
            if matchingRegistrations.count == 1 {
                self.isLoginButtonClicked = true
                return true
            } else {
                self.isLoginButtonClicked = false
                return false
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
