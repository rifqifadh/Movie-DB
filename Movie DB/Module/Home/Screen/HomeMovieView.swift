//
//  HomeView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeMovieView: View {
  
  @ObservedObject var viewModel: HomeViewModel
  @State private var progress = 0.5
  
  var body: some View {
    switch viewModel.state {
    case .idle, .loading:
      ProgressView()
    case .error(let error):
      Text("Error \(error.localizedDescription)")
    case .loaded:
      NavigationView {
        List {
          ForEach(viewModel.homeSection.sorted(by: ==), id: \.key) { key, value in
            HomeRowView(viewModel: viewModel, title: key.rawValue, items: value)
          }
          .listRowInsets(EdgeInsets())
        }
        .navigationTitle("Movies DB")
      }
    }
  }
}
