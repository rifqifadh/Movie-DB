//
//  HomeInteractor.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine

protocol HomeUseCase {
  
  func getDiscoverMovies() -> AnyPublisher<[MovieModel], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: TmdbRepository
  
  required init(repository: TmdbRepository) {
    self.repository = repository
  }
  
  func getDiscoverMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getDiscoverMovies()
  }
}
