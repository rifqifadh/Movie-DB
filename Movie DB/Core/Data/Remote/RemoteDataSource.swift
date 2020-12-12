//
//  RemoteDataSource.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol: class {
  
  func getTopRatedMovies() -> AnyPublisher<MovieResponses, Error>
  func getPopularMovies() -> AnyPublisher<MovieResponses, Error>
  func getNowPlayingMovies() -> AnyPublisher<MovieResponses, Error>
  func getUpcomingMovies() -> AnyPublisher<MovieResponses, Error>
  func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieResponse, Error>
  func getCredits(id: Int) -> AnyPublisher<CreditResponse, Error>
}

final class RemoteDataSource: NSObject {
  private override init() {}
  
  static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  // MARK: - GET Discover Movies
  func getTopRatedMovies() -> AnyPublisher<MovieResponses, Error> {
    TMDBServices.fetch(from: .topRated, response: MovieResponses.self)
      .eraseToAnyPublisher()
  }
  
  // MARK: - GET Popular Movies
  func getPopularMovies() -> AnyPublisher<MovieResponses, Error> {
    TMDBServices.fetch(from: .popularMovies, response: MovieResponses.self)
      .eraseToAnyPublisher()
  }
  
  // MARK: - GET Now Playing Movies
  func getNowPlayingMovies() -> AnyPublisher<MovieResponses, Error> {
    TMDBServices.fetch(from: .nowPlayingMovies, response: MovieResponses.self)
      .eraseToAnyPublisher()
  }
  
  // MARK: - GET Upcoming Movies
  func getUpcomingMovies() -> AnyPublisher<MovieResponses, Error> {
    TMDBServices.fetch(from: .upcomingMovies, response: MovieResponses.self)
      .eraseToAnyPublisher()
  }
  
  // MARK: - GET Detail Movie
  func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieResponse, Error> {
    TMDBServices.fetch(from: .detailMovie(id: id), response: DetailMovieResponse.self)
      .eraseToAnyPublisher()
  }
  
  // MARK: - GET Credits
  func getCredits(id: Int) -> AnyPublisher<CreditResponse, Error> {
    TMDBServices.fetch(from: .credits(id: id), response: CreditResponse.self)
      .eraseToAnyPublisher()
  }
}
