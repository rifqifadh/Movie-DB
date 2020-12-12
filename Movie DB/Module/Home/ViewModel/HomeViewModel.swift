//
//  HomeViewModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
  
  enum State {
    case idle
    case loading
    case error(Error)
    case loaded
  }
  
  private var cancellable = Set<AnyCancellable>()
  private let homeUseCase: HomeUseCase
  private let router = HomeRouter()
  
  @Published private(set) var state = State.idle
  @Published private(set) var discoverMovies: [MovieModel] = []
  @Published private(set) var homeSection = [HomeSection: [MovieModel]]()
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
    state = .loading
    
    homeUseCase.getHomeSection()
      .receive(on: RunLoop.main)
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.state = .loaded
        case.failure(let error):
          self?.state = .error(error)
        }
      } receiveValue: { value in
        self.homeSection = value
      }
      .store(in: &cancellable)
  }
  
  func linkBuilder<Content: View>(
    for movie: MovieModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: movie)) { content() }
  }
}
