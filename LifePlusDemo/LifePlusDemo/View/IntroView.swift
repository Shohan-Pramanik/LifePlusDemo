//
//  IntroView.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 5/5/23.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Image("lifePlus_logo2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Lifeplus Bangladesh")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .bold()
                VStack {
                    Text("Loading...")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
            }
            
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
            .preferredColorScheme(.dark)
    }
}
