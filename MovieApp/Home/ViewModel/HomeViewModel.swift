//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by 1 on 12/5/1402 AP.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var trendingMovies: MovieResponse?
    @Published var topRatedMovies: MovieResponse?
    @Published var genresList: GenresList?
    @Published var loadTrending = false
    @Published var loadTopRated = false
    
    func fetchTrendingMovie(page: Int? = nil) async {
        trendingMovies = try? await APIService.fetchData(url: APIConstant.trendingURL, page: page)
    }
    
    func fetchMoreTrendingMovie() async {
        if let movies = trendingMovies , movies.totalPages > movies.page, !loadTrending {
            let response: MovieResponse? = try? await APIService.fetchData(url: APIConstant.trendingURL, page: movies.page + 1)
            guard let response = response else {
                loadTrending = false
                return
            }
            trendingMovies?.page = movies.page + 1
            trendingMovies?.results = movies.results + response.results
            loadTrending = false
        }
    }
    
    func fetchTopRatedMovies(page: Int? = nil) async {
        topRatedMovies = try? await APIService.fetchData(url: APIConstant.topRatedURL, page: page)
    }
    
    func fetchMoreTopRatedMovies() async {
        if let movies = topRatedMovies , movies.totalPages > movies.page, !loadTopRated {
            loadTopRated = true
            let response: MovieResponse? = try? await APIService.fetchData(url: APIConstant.topRatedURL, page: movies.page + 1)
            guard let response = response else {
                loadTopRated = false
                return
            }
            topRatedMovies?.page = movies.page + 1
            topRatedMovies?.results = movies.results + response.results
            loadTopRated = false
        }
    }
    
    func fetchGenreList() async {
        let response: GenresList? = try? await APIService.fetchData(url: APIConstant.genreList, page: nil)
        guard let response = response else {
            return
        }
        genresList = response
    }
}
