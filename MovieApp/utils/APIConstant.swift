//
//  APIConstant.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import Foundation


enum APIConstant {
    static var accept = "application/json"
    static var Authorization = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNDdhNTBjMDRiN2E4Yzk0ZGFmMTlkZGYxZTc3MDc0YSIsInN1YiI6IjYzMDIxNDA3NWY0YjczMDA4MjY3ZmQ2ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._f4zJ7kI5qhE8DPzTfygm1dC7XasvYoo9SAxl7cNe1g"
    static var imageBaseURL = "https://image.tmdb.org/t/p/original"
    static var apiBaseURL = "https://api.themoviedb.org"
    static var trendingURL = "https://api.themoviedb.org/3/trending/movie/week"
    static var topRatedURL = "https://api.themoviedb.org/3/movie/top_rated"
    static var genreList = "https://api.themoviedb.org/3/genre/movie/list"
    static var movieDetailURL = "https://api.themoviedb.org/3/movie"
    
}


struct APIService {
    static func getURL(url: String, page: Int?) -> URLRequest {
        var components = URLComponents(string: url)!
        if let page = page {
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
            ]
        }
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(APIConstant.accept, forHTTPHeaderField: "accept")
        urlRequest.setValue(APIConstant.Authorization, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    static func fetchData<T:Decodable>(url: String, page: Int?) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: getURL(url: url, page: page))
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw CustomError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}


enum CustomError: Error {
    case invalidResponse
    case invalidData
    case invalidURL
}
