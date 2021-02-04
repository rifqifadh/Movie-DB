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
      
      Text(plot)
        .font(.caption)
        .padding(.vertical, 5)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
  }
}

var plot = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
