//
//  HomeView.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import SwiftUI

struct HomeView: View {
    @State var searchText: String = ""
    @StateObject var viewModel = HomeViewModel()
    @State var selected: Int = 0
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack {
                    Text("What do you want to watch?")
                        .bold()
                        .font(.system(size: 20))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                    
                    SearchBar(searchText: $searchText)
                        .padding(.horizontal)
                        
                    
                    Text("Trending Movies")
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                    if let movies = viewModel.trendingMovies {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(movies.results) { movie in
                                    NavigationLink(value: movie.id) {
                                        MovieCard(movie: movie, cardType: .poster)
                                    }
                                }
                                
                                if movies.page < movies.totalPages {
                                    CardLoader(cardType: .poster)
                                        .task {
                                            await viewModel.fetchMoreTrendingMovie()
                                        }
                                }
                            }
                        }
                    } else {
                        ProgressView()
                    }
                    
                    Text("Top Rated Movies")
                        .bold()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                    
                    if let genresList = viewModel.genresList {
                        FilterBar(selected: $selected, genresList: genresList)
                    }
                    
                    if let movies = viewModel.topRatedMovies {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()) ]) {
                            ForEach(movies.results) { movie in
                                if selected == 0 || movie.genreIDS.contains(selected) {
                                    if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                                        NavigationLink(value: movie.id) {
                                            MovieCard(movie: movie, cardType: .grid)
                                        }
                                    } else if movie.title.lowercased().contains(searchText.trimmingCharacters(in: .whitespaces).lowercased()) {
                                        NavigationLink(value: movie.id) {
                                            MovieCard(movie: movie, cardType: .grid)
                                        }
                                    }
                                }
                            }
                            if movies.page < movies.totalPages && selected == 0{
                                CardLoader(cardType: .grid)
                                    .task {
                                        await viewModel.fetchMoreTopRatedMovies()
                                    }
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationDestination(for: Int.self) { item in
                MovieDetailView(id: item)
            }
            .task {
                await viewModel.fetchGenreList()
                await viewModel.fetchTrendingMovie()
                await viewModel.fetchTopRatedMovies()
            }
        }
        
    }
}


#Preview {
    HomeView()
}
