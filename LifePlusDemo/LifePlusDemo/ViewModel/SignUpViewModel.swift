//
//  SignUpViewModel.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import Foundation
import CoreData

class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var phone: String = ""
    
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    func save() async {
        do {
            let person = Person(context: viewContext)
            person.name = name
            person.username = username
            person.password = password
            person.phone = phone
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
