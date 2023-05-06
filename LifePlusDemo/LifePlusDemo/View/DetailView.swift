//
//  DetailView.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 6/5/23.
//

import SwiftUI

struct DetailView: View {
    @State private var image: UIImage? = nil
    let show: Show
    init(show: Show) {
        self.show = show
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                VStack {
                    if let uiImage = image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Text("Loading...")
                            .onAppear {
                                loadImage()
                            }
                    }
                    Text(show.name)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Arial", size: 16).bold())
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(show.name)
                        .foregroundColor(.black)
                        .font(Font.custom("Arial", size: 20).bold())
                    Text(show.summary ?? "")
                        .foregroundColor(.black.opacity(0.8))
                        .font(Font.custom("Arial", size: 16))
                }
                .multilineTextAlignment(.leading)
            }
            HStack {
                Text("Language:")
                Text(show.language ?? "Unknown")
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Arial", size: 16).bold())
            HStack {
                Text("Network Name:")
                Text(show.network?.name ?? "Unknown")
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .font(Font.custom("Arial", size: 16).bold())
        }
        .padding()
        Spacer()
    }
    
    private func loadImage() {
            guard let urlString = show.image?.original,
                  let url = URL(string: urlString) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data,
                   let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = uiImage
                    }
                } else {
                    print("Error loading image: \(error?.localizedDescription ?? "unknown error")")
                }
            }.resume()
        }
}

