//
//  FavoritesMovieView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 08/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteMoviesView: View {
  @ObservedObject var viewModel: FavoriteMoviesViewModel
  
  var body: some View {
    NavigationView {
      ScrollView {
        switch viewModel.state {
        case .idle, .loading:
          ProgressView()
        case .error(let error):
          Text("Error \(error.localizedDescription)")
        case .loaded:
          if viewModel.favoriteMovies.isEmpty {
            EmptyState()
              .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
          } else {
            ForEach(viewModel.favoriteMovies) { movie in
              ZStack {
                self.viewModel.linkBuilder(for: movie) {
                  CardFavoriteView(movie: movie)
                    .padding(.horizontal)
                }.buttonStyle(PlainButtonStyle())
              }
            }
          }
        }
      }
      .navigationBarTitle("Favorites")
      .background(Color.colorGreyLight.ignoresSafeArea(.all))
    }
    .onAppear {
      viewModel.getFavoriteMovies()
    }
  }
}

struct EmptyState: View {
  var body: some View {
    VStack {
      Image("emptyIllustration")
        .resizable()
        .frame(width: 180, height: 180)
      Text("Favorite Movie Empty")
        .font(.title)
        .fontWeight(.bold)
        .multilineTextAlignment(.center)
      Text("Add Movie to Favorite in Detail Movie")
        .font(.caption)
        .fontWeight(.light)
        .multilineTextAlignment(.center)
    }
  }
}
