//
//  FavoriteViewModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 10/11/20.
//

import Foundation
import Combine
import SwiftUI

class FavoriteMoviesViewModel: ObservableObject {
  
  enum State {
    case idle
    case loading
    case error(Error)
    case loaded
  }
  
  private var cancellables = Set<AnyCancellable>()
  private let favoriteMoviesUseCase: FavoriteMoviesUseCase
  private let router = FavoriteMovieRouter()
  
  @Published private(set) var state = State.idle
  @Published private(set) var favoriteMovies: [MovieModel] = []
  
  init(favoriteMoviesUseCase: FavoriteMoviesUseCase) {
    self.favoriteMoviesUseCase = favoriteMoviesUseCase
  }
  
  func getFavoriteMovies() {
    self.favoriteMoviesUseCase.getFavoriteMovies()
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.state = .loaded
        case .failure(let error):
          self.state = .error(error)
        }
      } receiveValue: { favorites in
        self.favoriteMovies = favorites
      }
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for movie: MovieModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) { content() }
  }
}
