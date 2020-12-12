//
//  DetailMovieModel.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 05/11/20.
//

import Foundation

struct DetailMovieModel {
  let id: Int
  let genres: [GenreModel]
  let homepage: String
  let imdbID, originalLanguage, originalTitle, overview: String
  let popularity: Double
  let posterPath, backdropPath: String
  let releaseDate: String
  let runtime: Int
  let status, tagline, title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  let casts: [CastModel]
  var crews: [CrewModel]
  var poster: String {
    TMDB.imageUrl + posterPath
  }
  var backdrop: String {
    TMDB.imageUrl + backdropPath
  }
  var genre: String {
    return genres.map { $0.name }.joined(separator: ",")
  }
  
  static var `default`: DetailMovieModel { DetailMovieModel(id: 531219, genres: [GenreModel(id: 11, name: ""), GenreModel(id: 12, name: "")], homepage: "", imdbID: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 1768.318, posterPath: "", backdropPath: "", releaseDate: "", runtime: 106, status: "", tagline: "", title: "", video: false, voteAverage: 7.1, voteCount: 492, casts: [CastModel(id: 1, character: "", name: "", order: 1, profilePath: ""), CastModel(id: 1, character: "", name: "", order: 1, profilePath: "")], crews: [CrewModel(id: 1, job: "", name: "", departement: "", order: 1)])}
}

struct GenreModel: Identifiable {
  let id: Int
  let name: String
}

struct CastModel: Identifiable {
  let id: Int
  let character, name: String
  let order: Int
  let profilePath: String?
  var profile: String {
    TMDB.imageUrl + (profilePath ?? "")
  }
}

struct CrewModel: Identifiable {
  let id: Int
  let job, name, departement: String
  let order: Int
}
