//
//  MovieDetail.swift
//  MovieApp
//
//  Created by 1 on 12/6/1402 AP.
//

import Foundation

struct MovieDetail: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbId, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
//    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

extension MovieDetail {
    var backdropFullPath: String {
        return APIConstant.imageBaseURL + backdropPath
    }
    
    var posterFullPath: String {
        return APIConstant.imageBaseURL + posterPath
    }
    
    var releaseYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: releaseDate)
        if let date = date {
            let calender = Calendar.current
            return calender.component(.year, from: date).description
        }
        return ""
    }
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath, name, originCountry: String
}


struct ProductionCountry: Codable {
    let name: String
}


struct SpokenLanguage: Codable {
    let englishName, name: String
}
