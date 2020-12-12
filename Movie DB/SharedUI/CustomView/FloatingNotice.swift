//
//  FloatingNotice.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 11/11/20.
//

import SwiftUI

struct FloatingNotice: View {
    @Binding var showingNotice: Bool
  var message: String
  var sfSymbol: String

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(systemName: sfSymbol)
                .foregroundColor(.white)
                .font(.system(size: 48, weight: .regular))
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 5))
            Text(message)
                .foregroundColor(.white)
                .font(.callout)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
        }
        .background(Color.black.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .clipped()
        .transition(.scale)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.showingNotice = false
            })
        })
        .frame(minWidth: 140, minHeight: 140)
    }
}
