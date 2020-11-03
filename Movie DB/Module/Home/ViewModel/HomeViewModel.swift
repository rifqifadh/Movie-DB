//
//  HomeViewModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  
  enum State {
    case idle
    case loading
    case error(Error)
    case loaded
  }
  
  private var cancellable = Set<AnyCancellable>()
  private let homeUseCase: HomeUseCase
  
  @Published private(set) var state = State.idle
  @Published private(set) var discoverMovies: [MovieModel] = []
  
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
    state = .loading

    homeUseCase.getDiscoverMovies()
      .receive(on: RunLoop.main)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.state = .loaded
        case.failure(let error):
          self?.state = .error(error)
        }
      } receiveValue: { movies in
        self.discoverMovies = movies
      }.store(in: &cancellable)
  }
}
