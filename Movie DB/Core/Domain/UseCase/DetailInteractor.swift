//
//  DetailInteractor.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 04/11/20.
//

import Foundation
import Combine

protocol DetailMovieUseCase {
  // MARK: - Remote
  func getMovie() -> MovieModel
  func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieModel, Error>
  
  // MARK: - Locale
  func addMovieToFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteMovieFromFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
  func movieIsFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error>
}

class DetailMovieInteractor: DetailMovieUseCase {
  
  private let repository: TmdbRepositoryProtocol
  private let movie: MovieModel
  
  required init(
    repository: TmdbRepositoryProtocol,
    movie: MovieModel
  ) {
    self.repository = repository
    self.movie = movie
  }
  
  func getMovie() -> MovieModel {
    return movie
  }
  
  func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieModel, Error> {
    return repository.getDetailMovie(id: id)
  }
  
  func addMovieToFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return repository.addMovieToFavorite(from: movie)
  }
  
  func deleteMovieFromFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return repository.deleteMovieFromFavorite(from: movie)
  }
  
  func movieIsFavorite(movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return repository.movieIsFavorite(from: movie)
  }
}
