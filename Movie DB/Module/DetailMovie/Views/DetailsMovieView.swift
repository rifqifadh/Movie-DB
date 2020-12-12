//
//  DetailsMovieView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 07/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsMovieView: View {
  let detailMovie: DetailMovieModel
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Text("Release Date: \(detailMovie.releaseDate)")
            .font(.caption)
            .foregroundColor(.secondary)
          Text(detailMovie.title)
            .fontWeight(.semibold)
            .font(.title3)
            .lineLimit(3)
          Text(detailMovie.genre)
            .font(.caption)
          
        }
        Spacer()
        
        ProgressView(value: (detailMovie.voteAverage * 10), total: 100)
          .progressViewStyle(
            CirclePercentageProgressViewStyle(
              strokeWidth: 6,
              fontType: .system(size: 10),
              fontColor: Color.white,
              primaryColor: Color.colorPrimary,
              secondaryColor: Color.colorSecondary.opacity(0.5))
          )
          .frame(width: 35, height: 35, alignment: .center)
      }
      
      Text(detailMovie.overview)
        .font(.caption)
        .padding(.vertical, 5)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
  }
}
