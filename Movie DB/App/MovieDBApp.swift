//
//  Movie_DBApp.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import SwiftUI

@main
struct MovieDBApp: App {
  @StateObject var viewModel = HomeViewModel(homeUseCase: Injection().provideHome())
  
  var body: some Scene {
    WindowGroup {
      HomeView(viewModel: viewModel)
    }
  }
}
