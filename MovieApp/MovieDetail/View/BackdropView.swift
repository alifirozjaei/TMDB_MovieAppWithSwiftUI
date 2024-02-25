//
//  BackdropView.swift
//  MovieApp
//
//  Created by 1 on 12/6/1402 AP.
//

import SwiftUI

struct BackdropView: View {
    let path: String
    var body: some View {
        Group {
            AsyncImage(url: URL(string: path)) { image in
                image
                    .resizable()
            } placeholder: {
                Color.secondary
            }
        }
        .overlay(content: {
            Color(red: 0, green: 0, blue: 0, opacity: 0.3)
        })
        .frame(height: 210)
        .frame(maxWidth: .infinity)
    }
}

//#Preview {
//    BackdropView()
//}
