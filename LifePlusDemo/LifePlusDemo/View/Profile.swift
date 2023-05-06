//
//  Profile.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

struct Profile: View {
    let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var phone: String = ""
    @Binding var showSidebar:Bool
    
    @ObservedObject private var viewModel: ProfileViewModel
    
    init(username: String, showSidebar: Binding<Bool>) {
        self._showSidebar = showSidebar
        viewModel = ProfileViewModel(context: viewContext)
        viewModel.fetchUser(username: username)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    showSidebar.toggle()
                }label: {
                    HStack {
                        Image("backButton")
                    }
                }
                Spacer()
                Text("Profile")
                    .foregroundColor(.black)
                    .font(Font.custom("Arial", size: 16).bold())
                    .padding(.trailing, 50)
                Spacer()
            }
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 20) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(Color("blueTheme"))
                        .frame(width: 64, height: 64)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Name: \(viewModel.name)")
                        Text("Username: \(viewModel.username)")
                        Text("Phone: \(viewModel.phone)")
                    }.foregroundColor(.black)
                    .font(Font.custom("Arial", size: 16))
                    .multilineTextAlignment(.leading)
                }
            }
            .padding()
            Spacer()
        }
    }
    
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        Profile(username: "", showSidebar: .constant(true))
    }
}
