//
//  HomeRow.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 03/11/20.
//

import SwiftUI

struct HomeRowView: View {
  
  @ObservedObject var viewModel: HomeViewModel
  
  var title: String
  var items: [MovieModel]
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(self.title)
        .font(.title3)
        .fontWeight(.medium)
        .padding(.leading, 15)
        .padding(.top, 5)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 0) {
          ForEach(items) { movie in
            ZStack {
              self.viewModel.linkBuilder(for: movie) {
                MovieCard(item: movie)
              }.buttonStyle(PlainButtonStyle())
            }.padding(.leading, 10)
          }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
      }
      .frame(height: 260)
    }
  }
}
