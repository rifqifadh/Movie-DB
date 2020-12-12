//
//  APICall.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

struct TMDB {
  static public let tmdbURL = URL(string: "https://api.themoviedb.org/3/")!
  static let apiKey = "967ad60bd20b9b2102526183323e3c3b"
  static let imageUrl = "https://image.tmdb.org/t/p/w500"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  //  enum Gets: Endpoint {
  case topRated
  case nowPlayingMovies
  case popularMovies
  case upcomingMovies
  case detailMovie(id: Int)
  case credits(id: Int)
  
  public func path() -> String {
    switch self {
    case .topRated:
      return "movie/top_rated"
    case .nowPlayingMovies:
      return "movie/now_playing"
    case .popularMovies:
      return "movie/popular"
    case .upcomingMovies:
      return "movie/upcoming"
    case let .detailMovie(id):
      return "movie/\(id)"
    case let .credits(id):
      return "movie/\(id)/credits"
    }
  }
}
