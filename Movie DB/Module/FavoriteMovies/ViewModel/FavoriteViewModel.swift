//
//  FavoriteViewModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 10/11/20.
//

import Foundation
import Combine

class FavoriteMoviesViewModel: ObservableObject {
  
  private let favoriteMoviesUseCase: FavoriteMoviesUseCase
  private var cancellables = Set<AnyCancellable>()
  
  init(favoriteMoviesUseCase: FavoriteMoviesUseCase) {
    self.favoriteMoviesUseCase = favoriteMoviesUseCase
  }
  
  func getFavoriteMovies() {
    self.favoriteMoviesUseCase.getFavoriteMovies()
      .receive(on: RunLoop.main)
      .sink { completion in
        print(completion)
      } receiveValue: { favorites in
        print(favorites)
      }
      .store(in: &cancellables)
  }
}
