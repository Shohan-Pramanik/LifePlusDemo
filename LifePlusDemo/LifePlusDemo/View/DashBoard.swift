//
//  DashBoard.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

struct DashBoard: View {
    let storedName = UserDefaults.standard.string(forKey: "userName")
    @State var searchKey: String = ""
    @State var showSidebar = false
    @ObservedObject var vm = Shows()
    @State var isDetailClicked = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke().foregroundColor(.black.opacity(0.2)))
                        .padding(.horizontal, 30)
                    Button {
                        Task {
                            let _ = await vm.getData(query: searchKey)
                        }
                    }label: {
                        Text("Enter")
                            .foregroundColor(.white)
                            .font(Font.custom("Arial", size: 16).bold())
                            .padding()
                            .frame(height: 38)
                            .background(Color("blueTheme"))
                            .cornerRadius(12)
                    }
                    Spacer()
                    
                }.padding(.top, 30)
                .padding(.trailing, 15)
                Spacer()
                Divider()
                    .foregroundColor(.blue)
                    .frame(height: 15)
                ScrollView {
                    VStack {
                        ForEach(vm.shows, id: \.self) { show in
                            NavigationLink(destination: DetailView(show: show)) {
                                showList(show: show)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showSidebar.toggle()
                    }label: {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(Color("blueTheme"))
                            .padding(.horizontal, 10)
                    }
                }
            }
            .navigationTitle("TV Shows")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showSidebar) {
                Profile(username: storedName ?? "", showSidebar: $showSidebar)
            }
        }
            
    }
    
    func showList(show: Show) -> some View {
        VStack {
            HStack {
                Text(show.name)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Arial", size: 16).bold())
                    .frame(height: 60)
                    .padding(.leading,15)
                Spacer()
            }
            Divider()
                .frame(height: 6)
                .overlay(.gray.opacity(0.2))
        }
    }
}

struct DashBoard_Previews: PreviewProvider {
    static var previews: some View {
        DashBoard()
    }
}
