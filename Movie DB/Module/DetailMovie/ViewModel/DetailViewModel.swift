//
//  DetailViewModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 04/11/20.
//

import Foundation
import Combine
import SwiftUI

class DetailMovieViewModel: ObservableObject {
  
  private let detailMovieUseCase: DetailMovieUseCase
  private var cancellables = Set<AnyCancellable>()
  
  @Published private(set) var movie: MovieModel
  @Published private(set) var detailMovie: DetailMovieModel = DetailMovieModel.default
  @Published private(set) var isLoading = false
  @Published private(set) var isFavorite = false
  @Published private(set) var messageInfo = ""
  @Published private(set) var sfSymbolInfo = "checkmark"
  @Published var showingInfo = false
  
  init(detailMovieUseCase: DetailMovieUseCase) {
    self.detailMovieUseCase = detailMovieUseCase
    movie = detailMovieUseCase.getMovie()
  }
  
  func getDetailMovie(id: Int) {
    isLoading = true
    self.detailMovieUseCase.getDetailMovie(id: movie.id)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.isLoading = false
        case .failure(let error):
          print("error \(error.localizedDescription)")
        }
      } receiveValue: { value in
        self.detailMovie = value
      }
      .store(in: &cancellables)
  }
  
  func addMovieToFavorite(movie: MovieModel) {
    self.detailMovieUseCase.addMovieToFavorite(movie: movie)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          self.showingInfo = true
          self.messageInfo = "Added to Favorite"
          self.sfSymbolInfo = "checkmark"
        case .failure:
          self.showingInfo = true
          self.messageInfo = "Failed add Favorite"
          self.sfSymbolInfo = "xmark.circle"
        }
      } receiveValue: { value in
        self.isFavorite = value
      }
      .store(in: &cancellables)
  }
  
  func checkIsFavorite(movie: MovieModel) {
    self.detailMovieUseCase.movieIsFavorite(movie: movie)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .finished:
          print("Finished")
        case .failure(let error):
          assertionFailure(error.localizedDescription)
        }
      } receiveValue: { value in
        self.isFavorite = value
      }
      .store(in: &cancellables)
  }
  
  func deleteFavorite() {
    self.detailMovieUseCase.deleteMovieFromFavorite(movie: movie)
      .sink { completion in
        switch completion {
        case .finished:
          print("Finished")
        case .failure(let error):
          assertionFailure(error.localizedDescription)
        }
      } receiveValue: { value in
        self.isFavorite = !value
      }
      .store(in: &cancellables)
  }
}
