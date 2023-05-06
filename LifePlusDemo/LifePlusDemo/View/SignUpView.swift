//
//  SignUpView.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var vm: SignUpViewModel
    @State var active: Bool = false
    @State var isalert: Bool = false
        
    var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                Image("lifePlus_logo2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Group {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name")
                            .foregroundColor(Color("blueTheme"))
                            .font(Font.custom("Arial", size: 16).bold())
                        TextField("Enter your name", text: $vm.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                    }.padding(.leading,20)
                        .padding(.trailing,20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("User Name")
                            .foregroundColor(Color("blueTheme"))
                            .font(Font.custom("Arial", size: 16).bold())
                        TextField("Enter your username", text: $vm.username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                    }.padding(.leading,20)
                        .padding(.trailing,20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Password")
                            .foregroundColor(Color("blueTheme"))
                            .font(Font.custom("Arial", size: 16).bold())
                        SecureField("Enter your password", text: $vm.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                    }.padding(.leading,20)
                        .padding(.trailing,20)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Phone Number")
                            .foregroundColor(Color("blueTheme"))
                            .font(Font.custom("Arial", size: 16).bold())
                        TextField("Enter your phone number", text: $vm.phone)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                    }.padding(.leading,20)
                        .padding(.trailing,20)
                    Button {
                        if !vm.name.isEmpty && !vm.username.isEmpty && !vm.password.isEmpty && !vm.phone.isEmpty {
                            Task {
                                let _ = await self.vm.save()
                                self.active = true
                                
                            }
                        }else {
                            self.active = false
                            self.isalert = true
                        }
                        
                    }label: {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .font(Font.custom("Arial", size: 16).bold())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("blueTheme"))
                            .cornerRadius(32)
                    }.padding()
                    Spacer(minLength: 10)
                }
            }.padding()
        .fullScreenCover(isPresented: $active) {
            LoginView(vm: LoginViewModel(context: viewContext))
        }
        .alert(isPresented: $isalert) {
            return Alert(title: Text("Error!").foregroundColor(.red), message: Text("Please fill up all the info."), dismissButton: .cancel(Text("OK")){
                self.isalert = false
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        SignUpView(vm: SignUpViewModel(viewContext: viewContext))
    }
}
