//
//  TmdbRepository.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine
import Network

protocol TmdbRepositoryProtocol {
  
  func getDiscoverMovies() -> AnyPublisher<[MovieModel], Error>
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
  func getDiscoverMovies() -> AnyPublisher<[MovieModel], Error> {
    
    return self.locale.getDiscoverMovies()
      .flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getDiscoverMovies()
            .map { MovieMapper.mapMovieResponsesToEntities(input: $0.results) }
            .flatMap { self.locale.addMovies(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getDiscoverMovies()
              .map { MovieMapper.mapMovieEntitiesToDomains(input: $0)}
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getDiscoverMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
}
