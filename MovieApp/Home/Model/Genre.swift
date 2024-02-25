//
//  GENRE.swift
//  MovieApp
//
//  Created by 1 on 12/5/1402 AP.
//

import Foundation

struct GenresList: Codable {
    let genres: [Genre]
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
