//
//  TmdbRepository.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine
import Network
import Alamofire

protocol TmdbRepositoryProtocol {
  // MARK: - Remote
  func getHomeSectionMovies() -> AnyPublisher<[HomeSection: [MovieModel]], Error>
  func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieModel, Error>
  
  // MARK: - Locale
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>
  func addMovieToFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error>
  func deleteMovieFromFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error>
  func movieIsFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error>
}

final class TmdbRepository: NSObject {
  
  typealias TmdbInstance = (RemoteDataSource, LocaleDataSource) -> TmdbRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource
  
  private init(remote: RemoteDataSource, locale: LocaleDataSource) {
    self.remote = remote
    self.locale = locale
  }
  
  static let sharedInstance: TmdbInstance = { remoteRepo, localeRepo in
    return TmdbRepository(remote: remoteRepo, locale: localeRepo)
  }
}

extension TmdbRepository: TmdbRepositoryProtocol {
  
  // MARK: GET Home Section Movies
  func getHomeSectionMovies() -> AnyPublisher<[HomeSection: [MovieModel]], Error> {
    Publishers.Zip4(
      self.remote.getTopRatedMovies().eraseToAnyPublisher(),
      self.remote.getPopularMovies().eraseToAnyPublisher(),
      self.remote.getNowPlayingMovies().eraseToAnyPublisher(),
      self.remote.getUpcomingMovies().eraseToAnyPublisher())
      .map { (result1, result2, result3, result4) in
        MovieMapper.mapMovieEntitiesToHomeSection(input1: result1.results,
                                                  input2: result2.results,
                                                  input3: result3.results,
                                                  input4: result4.results)
      }
      .eraseToAnyPublisher()
  }
  
  func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieModel, Error> {
    Publishers.Zip(self.remote.getDetailMovie(id: id), self.remote.getCredits(id: id))
      .map { (detailResponse, creditResponse) in
        DetailMovieMapper.mapDetailMovieResponseToDomains(movieResponse: detailResponse, creditResponse: creditResponse)
      }
      .eraseToAnyPublisher()
  }
  
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return locale.getFavoriteMovies()
      .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func addMovieToFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return locale.addMovieToFavorite(from: MovieMapper.mapMovieDomainsToEntities(input: movie))
      .eraseToAnyPublisher()
  }
  
  func deleteMovieFromFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return locale.deleteMovieFromFavorite(from: MovieMapper.mapMovieDomainsToEntities(input: movie))
      .eraseToAnyPublisher()
  }
  
  func movieIsFavorite(from movie: MovieModel) -> AnyPublisher<Bool, Error> {
    return locale.movieIsFavorite(from: MovieMapper.mapMovieDomainsToEntities(input: movie))
      .eraseToAnyPublisher()
  }
}
