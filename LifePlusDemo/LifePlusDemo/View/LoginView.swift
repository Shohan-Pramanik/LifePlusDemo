//
//  LoginView.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username: String = ""
    @State private var password: String = ""
    @State var isSignUpLinkActive = false
    @State var isValid = false
    @State var fieldValidation = false
    @State var wrongUsernamePassword = false
    @AppStorage("userName") private var userName = ""
    
    @ObservedObject var vm: LoginViewModel
    
    var body: some View {
        NavigationView() {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Image("lifePlus_logo2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    Group {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("User Name")
                                .foregroundColor(Color("blueTheme"))
                                .font(Font.custom("Arial", size: 16).bold())
                            TextField("Enter your username", text: $username)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                        }.padding(.leading,20)
                            .padding(.trailing,20)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Password")
                                .foregroundColor(Color("blueTheme"))
                                .font(Font.custom("Arial", size: 16).bold())
                            SecureField("Enter your password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                        }.padding(.leading,20)
                            .padding(.trailing,20)
                    }
                    
                    Button{
                        if !username.isEmpty && !password.isEmpty {
                            fieldValidation = false
                            Task {
                                isValid = await self.vm.validateLoginData(username: username, password: password)
                                userName = username
                                wrongUsernamePassword = !isValid
                                print("UserName: \(userName)")
                            }
                            
                        } else {
                            fieldValidation = true
                        }
                        
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(Font.custom("Arial", size: 16).bold())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("blueTheme"))
                            .cornerRadius(32)
                    }.padding()
                        .alert(isPresented: $fieldValidation) {
                            return Alert(title: Text("Error!").foregroundColor(.red), message: Text("Please fill up all the info."), dismissButton: .cancel(Text("OK")){
                                self.fieldValidation = false
                            })
                        }
                        .alert(isPresented: $wrongUsernamePassword) {
                            return Alert(title: Text("Error!").foregroundColor(.red), message: Text("Invalid Username or password."), dismissButton: .cancel(Text("OK")){
                                self.wrongUsernamePassword = false
                            })
                        }
                    Spacer()
                    
                }.padding()
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: SignUpView(vm: SignUpViewModel(viewContext: viewContext)), isActive: $isSignUpLinkActive) {
                        EmptyView()
                    }
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.6))
                    Button{
                        self.isSignUpLinkActive = true
                    }label: {
                        Text("Sign Up")
                            .foregroundColor(Color("blueTheme"))
                            .font(Font.custom("Arial", size:16).bold())
                    }
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $isValid) {
                DashBoard()
            }
        }
        .background(.white)
            
    }
}
