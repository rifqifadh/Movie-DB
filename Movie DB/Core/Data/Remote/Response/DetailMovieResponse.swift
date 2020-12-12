//
//  DetailMovieResponse.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 05/11/20.
//

import Foundation

struct DetailMovieResponse: Codable {
  
  let id: Int
  let genres: [GenreResponse]
  let homepage: String
  let imdbId, originalLanguage, originalTitle, overview: String
  let popularity: Double
  let posterPath, backdropPath: String
  let releaseDate: String
  let runtime: Int
  let status, tagline, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
}

// MARK: - Genre
struct GenreResponse: Codable, Identifiable {
    let id: Int
    let name: String
}
