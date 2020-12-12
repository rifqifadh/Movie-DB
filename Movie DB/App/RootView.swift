//
//  RootView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import SwiftUI

struct RootView: View {
  @StateObject var homeViewModel = HomeViewModel(homeUseCase: Injection().provideHome())
  @StateObject var favoriteViewModel = FavoriteMoviesViewModel(favoriteMoviesUseCase: Injection().provideFavoriteMovies())
  @State var selectedView = 0
  
    var body: some View {
      TabView(selection: $selectedView) {
        HomeMovieView(viewModel: homeViewModel)
          .tabItem {
            Image(systemName: "house")
            Text("Home")
          }
          .tag(0)
        
        FavoriteMoviesView(viewModel: favoriteViewModel)
          .tabItem {
            Image(systemName: "heart")
            Text("Favorite")
          }
          .tag(1)
        
        AccountView()
          .tabItem {
            Image(systemName: "person")
            Text("Account")
          }
          .tag(2)
      }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
