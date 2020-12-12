//
//  CastMovieView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 07/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CastMovieView: View {
  let detailMovie: DetailMovieModel
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Casts")
        .padding(.horizontal, 16)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          ForEach(detailMovie.casts) { cast in
            VStack(alignment: .leading) {
              WebImage(url: URL(string: cast.profile))
                .resizable()
                .placeholder {
                  Image("broken_image")
                    .resizable()
                    .frame(width: 70, height: 70, alignment: .center)
                }
                .indicator(.activity)
                .cornerRadius(10)
                .frame(width: 70, height: 100)
              
              VStack(alignment: .leading) {
                Text(cast.name)
                  .font(.caption2)
                  .lineLimit(2)
                
                Text(cast.character)
                  .font(.caption2)
                  .foregroundColor(.secondary)
                  .lineLimit(2)
              }
              
              Spacer()
            }
            .frame(width: 70, height: 170, alignment: .leading)
          }
          .listRowInsets(EdgeInsets())
        }
        .padding(.horizontal, 16)
      }
    }
  }
}
