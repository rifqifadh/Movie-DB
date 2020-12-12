//
//  FavoriteMovieInteractor.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 10/11/20.
//

import Foundation
import Combine

protocol FavoriteMoviesUseCase {
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
}

class FavoriteMoviesInteractor: FavoriteMoviesUseCase {
  private let repository: TmdbRepository
  
  required init(repository: TmdbRepository) {
    self.repository = repository
  }
  
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getFavoriteMovies()
  }
}
