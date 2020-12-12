//
//  HomeInteractor.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine

protocol HomeUseCase {
  
  func getHomeSection() -> AnyPublisher<[HomeSection: [MovieModel]], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: TmdbRepository
  
  required init(repository: TmdbRepository) {
    self.repository = repository
  }
  
  func getHomeSection() -> AnyPublisher<[HomeSection: [MovieModel]], Error> {
    return repository.getHomeSectionMovies()
  }
}
