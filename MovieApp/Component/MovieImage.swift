//
//  MovieImage.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import SwiftUI

struct MovieImage: View {
    let movie: Movie
    let itemHeight: CGFloat
    let itemWidth: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: movie.imageURLString)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.rect(cornerRadius: 20))
                .frame(width:itemWidth, height: itemHeight)
        } placeholder: {
            ZStack {
                Color.gray.opacity(0.3)
                
                Text(movie.title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .clipShape(.rect(cornerRadius: 20))
            .frame(width:itemWidth, height: itemHeight)
        }
    }    
}



#Preview {
    MovieImage(movie: dummyMovie, itemHeight: 200, itemWidth: 150)
}
