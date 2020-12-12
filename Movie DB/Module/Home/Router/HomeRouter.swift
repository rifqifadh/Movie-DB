//
//  HomeRouter.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 04/11/20.
//

import SwiftUI

class HomeRouter {
  
  func makeDetailView(for movie: MovieModel) -> some View {
    let detailMovieUseCase = Injection.init().provideDetailMovie(movie: movie)
    let viewModel = DetailMovieViewModel(detailMovieUseCase: detailMovieUseCase)
    return DetailMovieView(viewModel: viewModel)
  }
}
