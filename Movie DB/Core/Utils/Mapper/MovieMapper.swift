//
//  MovieMapper.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

final class MovieMapper {
 
//  static func mapResults<T>(input response: Response<T>) -> T {
//    return response.results
//  }
  
  static func mapMovieResponsesToDomains(input movieResponse: [MovieResponse]) -> [MovieModel] {
    return movieResponse.map { result in
      return MovieModel(
        id: result.id ?? 0,
        title: result.title ?? "",
        overview: result.overview ?? "",
        voteAverage: result.voteAverage ?? 0,
        posterPath: result.posterPath ?? "",
        backdropPath: result.backdropPath ?? "",
        releaseDate: result.releaseDate ?? ""
      )
    }
  }
  
  static func mapMovieResponsesToEntities(input movieResponse: [MovieResponse]) -> [MovieEntity] {
    return movieResponse.map { result in
      let newMovie = MovieEntity()
      newMovie.id = result.id ?? 0
      newMovie.title = result.title ?? ""
      newMovie.overview = result.overview ?? ""
      newMovie.voteAverage = result.voteAverage ?? 0
      newMovie.posterPath = result.posterPath ?? ""
      newMovie.backdropPath = result.backdropPath ?? ""
      newMovie.releaseDate = result.releaseDate ?? ""
      return newMovie
    }
  }
  
  static func mapMovieEntitiesToDomains(input movieEntity: [MovieEntity]) -> [MovieModel] {
    return movieEntity.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        overview: result.overview,
        voteAverage: result.voteAverage,
        posterPath: result.posterPath,
        backdropPath: result.backdropPath,
        releaseDate: result.releaseDate
      )
    }
  }
}
