//
//  CardLoader.swift
//  MovieApp
//
//  Created by 1 on 12/5/1402 AP.
//

import SwiftUI

struct CardLoader: View {
    let cardType: MovieCardType
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
            
            ProgressView()
        }
        .clipShape(.rect(cornerRadius: 15))
        .frame(width:itemWidth, height: itemHeight)
    }
}

extension CardLoader {
    var itemWidth: CGFloat {
        UIScreen.main.bounds.width * cardType.widthPercent
    }
    
    var itemHeight: CGFloat {
        UIScreen.main.bounds.height * cardType.heightPercent
    }
}

#Preview {
    CardLoader(cardType: .poster)
}
