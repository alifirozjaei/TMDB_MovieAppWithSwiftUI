//
//  MovieCard.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    let cardType: MovieCardType
    
    var body: some View {
        MovieImage(movie: movie, itemHeight: itemHeight, itemWidth: itemWidth)
    }
}


extension MovieCard {
    var itemWidth: CGFloat {
        UIScreen.main.bounds.width * cardType.widthPercent
    }
    
    var itemHeight: CGFloat {
        UIScreen.main.bounds.height * cardType.heightPercent
    }
}





let dummyMovie = Movie(adult: false, backdropPath: "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg", genreIDS: [18, 80], id: 278, originalLanguage: "en", originalTitle: "The Shawshank Redemption", overview: "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.", popularity: 139.788, posterPath: "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg", releaseDate: "1994-09-23", title: "The Shawshank Redemption", video: false, voteAverage: 8.704, voteCount: 25637)

#Preview {
    MovieCard(movie: dummyMovie, cardType: .grid)
}
