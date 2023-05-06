//
//  SearchShows.swift
//  LifePlusDemo
//
//  Created by Shohan Pramanik on 6/5/23.
//

import Foundation

struct SearchShows: Codable {
    var show: Show
}

struct Show: Codable, Identifiable, Hashable {
    static func == (lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(language)
        hasher.combine(summary)
        hasher.combine(genres)
        hasher.combine(rating)
        hasher.combine(network)
    }
    
    let id: Int
    var name: String
    var language: String?
    var summary: String?
    var genres: [String]?
    var rating: Rating?
    var network: Network?
    var image: Images?
}

struct Rating: Codable, Hashable {
    var average: Double?
}

struct Network: Codable, Hashable {
    var name: String?
}

struct Images: Codable, Hashable {
    var original: String?
}
