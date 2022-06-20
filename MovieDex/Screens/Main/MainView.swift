//
//  MainView.swift
//  MovieDex
//
//  Created by Admin on 20.06.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "film")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
