//
//  SearchBar.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search", text: $searchText)
            .frame(height: 60)
            .padding(.horizontal, 15)
            .overlay {
                ZStack(alignment:.trailing) {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke()
                    
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .rotationEffect(.degrees(90))
                }
            }
    }
}

//#Preview {
//    SearchBar()
//}
