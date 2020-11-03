//
//  APICall.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

struct TMDB {
  static let tmdbURL = "https://api.themoviedb.org/3/"
  static let apiKey = "967ad60bd20b9b2102526183323e3c3b"
  static let imageUrl = "https://image.tmdb.org/t/p/w500"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case discoverMovies
    
    public var url: String {
      switch self {
      case .discoverMovies:
        return "\(TMDB.tmdbURL)discover/movie?api_key=\(TMDB.apiKey)&sort_by=popularity.desc"
      }
    }
  }
}
