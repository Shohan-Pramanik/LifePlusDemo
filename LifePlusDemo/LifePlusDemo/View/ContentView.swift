//
//  ContentView.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isActive = false
    var body: some View {
        VStack {
            if self.isActive {
                LoginView(vm: LoginViewModel(context: viewContext))
            } else {
                IntroView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isActive = true
            }
        }
    }
}
