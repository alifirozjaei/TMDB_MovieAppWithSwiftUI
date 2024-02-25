//
//  ContentView.swift
//  MovieApp
//
//  Created by 1 on 12/4/1402 AP.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Bookmark List Movies")
                .tabItem {
                    Label("Bookmark List", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
