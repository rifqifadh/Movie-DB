//
//  CardFavoriteView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 10/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardFavoriteView: View {
  let movie: MovieModel
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.white
        .cornerRadius(18)
      
      HStack(alignment: .top) {
        WebImage(url: URL(string: movie.poster))
          .resizable()
          .indicator(.activity)
          .cornerRadius(18)
          .frame(width: 90, height: 130)
          .offset(x: 0, y: -30)
          .padding(.leading, 16)
        
        VStack(alignment: .leading, spacing: 3) {
          Text(movie.title)
            .font(.system(size: 14, weight: .bold, design: .default))
            .lineLimit(2)
          
          Text(movie.releaseDateFormatted)
            .font(.caption)
            .foregroundColor(.secondary)

          Text(movie.overview)
            .font(.caption)
            .foregroundColor(.secondary)
            .lineLimit(2)
                    
          Spacer()
        }
        .padding(.top, 16)
        
        Spacer()
        
        ProgressView(value: 90, total: 100)
          .progressViewStyle(CirclePercentageProgressViewStyle(strokeWidth: 8, fontType: .caption, fontColor: .white, primaryColor: .colorPrimary, secondaryColor: .white))
          .frame(width: 35, height: 35)
          .padding()
      }
    }
    .frame(height: 130)
    .padding(.top, 40)
  }
}
