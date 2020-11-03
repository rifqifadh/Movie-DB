//
//  Movie.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

struct MovieResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case voteAverage = "vote_average"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    
  }
  
  let id: Int?
  let title: String?
  let overview: String?
  let voteAverage: Double?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
}
