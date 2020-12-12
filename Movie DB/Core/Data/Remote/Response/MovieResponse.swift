//
//  Movie.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

struct MovieResponses: Codable {
  
  let page: Int?
  let results: [MovieResponse]
}

struct MovieResponse: Codable {
  
  let id: Int?
  let title: String?
  let overview: String?
  let voteAverage: Double?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  
}
