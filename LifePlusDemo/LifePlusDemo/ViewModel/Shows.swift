//
//  Shows.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 6/5/23.
//

import Foundation

class Shows: ObservableObject {
    @Published var shows: [Show] = []
    
    func getData(query: String) async {
        var urlString = "https://api.tvmaze.com/search/shows?q=\(query)"
        print("Our url \(urlString)")
        guard let url = URL(string: urlString) else {
            print("Wrong URL")
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            do {
                let results = try JSONDecoder().decode([SearchShows].self, from: data!)
                DispatchQueue.main.async {
                    self.shows = results.map {$0.show}
                    print("Shows: \(self.shows)")
                }
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
        }.resume()
        
    }
}

