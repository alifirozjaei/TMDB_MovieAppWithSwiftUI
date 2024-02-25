//
//  FilterBar.swift
//  MovieApp
//
//  Created by 1 on 12/5/1402 AP.
//

import SwiftUI

struct FilterBar: View {
    @Binding var selected: Int
    var genresList: GenresList
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Text("All")
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(selected == 0 ? .blue : .clear)
                    .foregroundStyle(selected == 0 ? .white : .secondary)
                    .onTapGesture {
                        withAnimation{
                            selected = 0
                        }
                    }
                    .clipShape(.rect(cornerRadius: 10))
                
                ForEach(genresList.genres) { genre in
                    Text(genre.name)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .foregroundStyle(selected == genre.id ? .white : .secondary)
                        .background(selected == genre.id ? .blue : .clear)
                        .onTapGesture {
                            withAnimation{
                                selected = genre.id
                            }
                        }
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
        }.scrollIndicators(.hidden)
            .padding(.bottom)
            .padding(.horizontal)
    }
}

//#Preview {
//    FilterBar()
//}
