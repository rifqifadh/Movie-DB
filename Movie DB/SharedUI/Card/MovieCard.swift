//
//  MovieCard.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 03/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
  var item: MovieModel
  
  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .bottomLeading) {
        WebImage(url: URL(string: item.poster ))
          .resizable()
          .indicator(.activity)
          .cornerRadius(10)
          .frame(width: 135, height: 190)
        
        ProgressView(value: item.rating, total: 100)
          .progressViewStyle(
            CirclePercentageProgressViewStyle(
              strokeWidth: 6,
              fontType: .system(size: 8),
              fontColor: Color.white,
              primaryColor: Color.colorPrimary,
              secondaryColor: Color.colorSecondary.opacity(0.5))
          )
          .frame(width: 30, height: 30, alignment: .center)
          .offset(y: 15)
          .padding(.leading, 5)
        
      }.frame(height: 210)
      
      Text(item.title)
        .font(.caption)
        .fontWeight(.medium)
        .lineLimit(2)
        .padding(.horizontal, 5)
      
      Spacer()
    }
    .frame(width: 135)
  }
}

struct MovieCard_Previews: PreviewProvider {
  static var previews: some View {
    MovieCard(item: MovieModel.default)
      .previewLayout(.sizeThatFits)
      .frame(width: 180, height: 270)
  }
}
