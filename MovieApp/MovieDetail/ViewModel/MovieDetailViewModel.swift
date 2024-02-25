//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by 1 on 12/6/1402 AP.
//

import Foundation
@MainActor
class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    @Published var isLoading = false
    
    func fetchMovieDetail(id: Int) async {
        isLoading = true
        do {
            //        Create Request URL
            let component = URLComponents(string: APIConstant.movieDetailURL + "/\(id)")
            guard let component = component else {
                throw CustomError.invalidURL
            }
            var urlRequest = URLRequest(url: component.url!)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue(APIConstant.accept, forHTTPHeaderField: "accept")
            urlRequest.setValue(APIConstant.Authorization, forHTTPHeaderField: "Authorization")
            
            //        Send Request
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            //        Check Valid Response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw CustomError.invalidResponse
            }
            
            //        Decode Data
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            movieDetail = try decoder.decode(MovieDetail.self, from: data)
        } catch {
            print(error)
        }
        isLoading = false
    }
}
