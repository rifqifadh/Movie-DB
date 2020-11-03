//
//  HomeView.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  
  @ObservedObject var viewModel: HomeViewModel
  
  @State private var progress = 0.5
  
  var columns: [GridItem] = [
    GridItem(.adaptive(minimum: 100), spacing: 8),
    GridItem(.adaptive(minimum: 100), spacing: 8),
    GridItem(.adaptive(minimum: 100), spacing: 8)
  ]
  
  var body: some View {
    switch viewModel.state {
    case .idle, .loading:
      ProgressView()
    case .error(let error):
      Text("Error \(error.localizedDescription)")
    case .loaded:
      ScrollView {
        LazyVGrid(columns: columns, alignment: .leading) {
          ForEach(viewModel.discoverMovies) { item in
            VStack(alignment: .leading) {
              ZStack(alignment: .topTrailing) {
                WebImage(url: URL(string: item.poster ))
                  .resizable()
                  .indicator(.activity)
                  .scaledToFill()
                  .frame(height: 190)
                
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
                  .padding(.top, 5)
                  .padding(.trailing, 5)
              }.frame(height: 190)
              
              VStack {
                Text(item.title)
                  .fontWeight(.medium)
                  .font(.caption)
                  .lineLimit(2)
              }
              .padding(.horizontal, 5)
              
              Spacer()
            }
            .background(Color.white)
            .cornerRadius(5)
            .frame(height: 240)
            .padding(.bottom, 10)
          }
        }
        .padding(.all, 10)
      }
      .background(Color.colorGreyLight.edgesIgnoringSafeArea(.all))
    }
  }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
