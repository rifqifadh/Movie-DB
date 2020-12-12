//
//  StickyHeader.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 04/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct StickyHeader<Header: View, Content: View>: View {
  
  var heightHeader: CGFloat
  let header: () -> Header
  let content: () -> Content
  
  init(
    heightHeader: CGFloat = 250,
    @ViewBuilder header: @escaping () -> Header,
    @ViewBuilder content: @escaping () -> Content) {
    self.heightHeader = heightHeader
    self.header = header
    self.content = content
  }
  
  var body: some View {
    ScrollView(.vertical) {
      GeometryReader { geometry in
          header()
            .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
            .blur(radius: self.getBlurRadiusForImage(geometry))
            .clipped()
            .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
      }
      .frame(height: heightHeader)
      
      content()
    }
    .edgesIgnoringSafeArea(.top)
  }
}

extension StickyHeader {
  private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
    return geometry.frame(in: .global).minY
  }
  
  private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    
    // Image was pulled down
    if offset > 0 {
      return -offset
    }
    return 0
  }
  
  private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = getScrollOffset(geometry)
    let imageHeight = geometry.size.height
    
    if offset > 0 {
      return imageHeight + offset
    }
    
    return imageHeight
  }
  
  private func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
    let offset = geometry.frame(in: .global).maxY
    
    let height = geometry.size.height
    let blur = (height - max(offset, 0)) / height
    
    return blur * 6
  }
}
