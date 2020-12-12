//
//  MovieModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

struct MovieModel: Equatable, Identifiable {
  
  let id: Int
  let title: String
  let overview: String
  let voteAverage: Double
  var rating: Float16 {
    Float16(voteAverage * 10)
  }
  let posterPath: String
  var poster: String {
    TMDB.imageUrl + posterPath
  }
  let backdropPath: String
  var backdrop: String {
    TMDB.imageUrl + backdropPath
  }
  let releaseDate: String
  var releaseDateFormatted: String {
    let date = releaseDate.toDate()
    return date.toString(format: "MMM dd,yyyy")
  }
  
  static var `default`: MovieModel { MovieModel(id: 0, title: "Roald Dahl's The Witches", overview: "", voteAverage: 7.1, posterPath: "/betExZlgK0l7CZ9CsCBVcwO1OjL.jpg", backdropPath: "", releaseDate: "")}
  
}
