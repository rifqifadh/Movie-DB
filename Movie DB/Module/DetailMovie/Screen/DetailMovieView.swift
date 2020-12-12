//
//  DetailMovieView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 04/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailMovieView: View {
  
  @ObservedObject var viewModel: DetailMovieViewModel
  @State private var showConfirmation = false
  
  var body: some View {
    ZStack {
      StickyHeader(heightHeader: 250) {
        WebImage(url: URL(string: viewModel.movie.backdrop))
          .resizable()
          .indicator(.activity)
          .aspectRatio(contentMode: .fill)
          .cornerRadius(15)
        
      } content: {
        DetailsMovieView(detailMovie: viewModel.detailMovie)
          .redacted(reason: viewModel.isLoading ? .placeholder : [])
        
        CastMovieView(detailMovie: viewModel.detailMovie)
          .redacted(reason: viewModel.isLoading ? .placeholder : [])
      }
      
      if viewModel.showingInfo {
        FloatingNotice(
          showingNotice: $viewModel.showingInfo,
          message: viewModel.messageInfo,
          sfSymbol: viewModel.sfSymbolInfo
        )
      }
    }
    .background(Color.colorGreyLight.ignoresSafeArea(.all))
    .onAppear {
      viewModel.getDetailMovie(id: viewModel.movie.id)
      viewModel.checkIsFavorite(movie: viewModel.movie)
    }
    .alert(isPresented: $showConfirmation) {
      Alert(
        title: Text("Are you sure want to delete \(viewModel.movie.title) from favorite?"),
        primaryButton: .cancel(Text("Cancel")),
        secondaryButton:
          .destructive(
            Text("Delete"),
            action: {
              viewModel.deleteFavorite()
            }
        )
      )
    }
    .navigationBarItems(
      trailing:
        Button(action: {
          if viewModel.isFavorite {
            self.showConfirmation = true
          } else {
            viewModel.addMovieToFavorite(movie: viewModel.movie)
          }
        }, label: {
          Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
        })
    )
  }
}

struct DetailMovieView_Previews: PreviewProvider {
  
  static var previews: some View {
    DetailMovieView(viewModel: DetailMovieViewModel(detailMovieUseCase: Injection().provideDetailMovie(movie: .default)))
  }
}
