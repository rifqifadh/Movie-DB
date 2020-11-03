//
//  CircleProgressViewStyle.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 02/11/20.
//

import SwiftUI

struct CirclePercentageProgressViewStyle: ProgressViewStyle {
  
  var strokeWidth: CGFloat = 10.0
  var fontType: Font = .title
  var fontColor = Color.black
  var primaryColor = Color.colorSecondary
  var secondaryColor = Color.colorSecondary.opacity(0.5)
  
  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      ZStack {
        Circle()
          .stroke(lineWidth: strokeWidth)
          .opacity(0.3)
          .foregroundColor(secondaryColor)
        
        
        Circle()
          .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0))
          .stroke(style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round, lineJoin: .round))
          .foregroundColor(primaryColor)
      }
      .rotationEffect(.degrees(-90))
      
      
      Text("\(Int((configuration.fractionCompleted ?? 0) * 100))%")
        .font(fontType)
        .fontWeight(.medium)
        .foregroundColor(fontColor)
    }
    .background(Color.black)
    .clipShape(Circle())
  }
}
