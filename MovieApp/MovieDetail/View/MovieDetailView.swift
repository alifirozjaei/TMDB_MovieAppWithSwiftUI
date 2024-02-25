//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by 1 on 12/6/1402 AP.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel = MovieDetailViewModel()
    @State var selectedItem: selectedTab = .overview
    let id: Int
    
    var body: some View {
        VStack {
            if let movie = viewModel.movieDetail {
                BackdropView(path: movie.backdropFullPath)
                    .overlay(alignment: .bottomTrailing) {
                        HStack {
                            Image(systemName: "star")
                                .font(.caption)
                            Text("\(movie.voteAverage, specifier: "%.1f")")
                                .font(.system(size: 14))
                        }
                        .padding(.all, 6)
                        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.8))
                        .clipShape(.rect(cornerRadius: 5))
                        .padding(.all, 5)
                        .foregroundColor(.yellow)
                    }
                
                
                VStack {
                    HStack{
                        Group {
                            AsyncImage(url: URL(string: movie.posterFullPath)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.secondary
                            }
                        }
                        .frame(width: 95, height: 120)
                        .clipShape(.rect(cornerRadius: 10))
                        
                        Text(movie.title)
                            .bold()
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 40)
                    
                    
                    
                    HStack {
                        Group {
                            Image(systemName: "calendar")
                            Text(movie.releaseYear)
                        }
                        Group {
                            Image(systemName: "clock")
                            Text("\(movie.runtime) Minutes")
                        }
                        Group {
                            Image(systemName: "square.grid.3x3.topleft.filled")
                            ForEach(movie.genres.prefix(3)) { item in
                                Text("\(item.name)")
                            }
                        }
                    }
                    .font(.caption)
                    .padding(.top)
                    
                    Group {
                        HStack {
                            Text("About Movie")
                                .bold()
                                .font(.caption)
                                .padding(.all, 5)
                                .background(selectedItem == .overview ? .blue : .clear)
                                .foregroundStyle(selectedItem == .overview ? .white : .primary)
                                .clipShape(.rect(cornerRadius: 5))
                                .onTapGesture{
                                    withAnimation {
                                        selectedItem = .overview
                                    }
                                }
                            
                            Text("More")
                                .bold()
                                .font(.caption)
                                .padding(.all, 5)
                                .background(selectedItem == .more ? .blue : .clear)
                                .foregroundStyle(selectedItem == .more ? .white : .primary)
                                .clipShape(.rect(cornerRadius: 5))
                                .onTapGesture{
                                    withAnimation {
                                        selectedItem = .more
                                    }
                                }
                            
                            Spacer()
                        }
                        
                        switch selectedItem {
                        case .overview:
                            Text(movie.overview)
                        case .more:
                            List {
                                Section("Country") {
                                    ForEach(movie.productionCountries, id: \.self.name) { item in
                                        Text(item.name)
                                            .font(.footnote)
                                    }
                                }
                                
                                Section(header: Text("Vote Count")) {
                                    Text("\(movie.voteCount)")
                                }
                                
                                Section(header: Text("Vote Average")) {
                                    Text("\(movie.voteAverage, specifier: "%.1f")")
                                }
                            }
                            .scrollContentBackground(.hidden)
                        
                        }
                    }.padding()
                }
                .offset(y: -70)
                Spacer()
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Image(systemName: "bookmark")
        }
        .task {
            await viewModel.fetchMovieDetail(id: id)
        }
    }
    
    enum selectedTab {
        case overview
        case more
    }
}

#Preview {
    MovieDetailView(id: 278)
}
