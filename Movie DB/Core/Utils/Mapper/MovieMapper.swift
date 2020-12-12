//
//  MovieMapper.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

enum HomeSection: String, CaseIterable, Comparable {
  case TopRated = "Top Rated"
  case Popular
  case NowPlaying = "Now Playing"
  case Upcoming
  
  private var sortOrder: Int {
    switch self {
    case .TopRated:
      return 0
    case .Popular:
      return 1
    case .NowPlaying:
      return 2
    case .Upcoming:
      return 3
    }
  }
  
  static func < (lhs: HomeSection, rhs: HomeSection) -> Bool {
    lhs.sortOrder < rhs.sortOrder
  }
}

final class MovieMapper {
  
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
  
  static func mapMovieDomainsToEntities(input movieModel: MovieModel) -> MovieEntity {
    let newMovie = MovieEntity()
    newMovie.id = movieModel.id
    newMovie.title = movieModel.title
    newMovie.overview = movieModel.overview
    newMovie.voteAverage = movieModel.voteAverage
    newMovie.posterPath = movieModel.posterPath
    newMovie.backdropPath = movieModel.backdropPath
    newMovie.releaseDate = movieModel.releaseDate
    return newMovie
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
  
  static func mapMovieEntitiesToHomeSection(
    input1 movieEntity1: [MovieResponse],
    input2 movieEntity2: [MovieResponse],
    input3 movieEntity3: [MovieResponse],
    input4 movieEntity4: [MovieResponse]) -> [HomeSection: [MovieModel]] {
    
    let mapped = [movieEntity1, movieEntity2, movieEntity3, movieEntity4].map { result in
      return result.map { subitem in
        return MovieModel(
          id: subitem.id ?? 0,
          title: subitem.title ?? "",
          overview: subitem.overview ?? "",
          voteAverage: subitem.voteAverage ?? 0,
          posterPath: subitem.posterPath ?? "",
          backdropPath: subitem.backdropPath ?? "",
          releaseDate: subitem.releaseDate ?? ""
        )
      }
    }
    
    let mapToDictonary = Dictionary(keys: HomeSection.allCases, values: mapped)
    
    return mapToDictonary
  }
}

extension Dictionary {
  public init(keys: [Key], values: [Value]) {
    precondition(keys.count == values.count)
    
    self.init()
    
    for (index, key) in keys.enumerated() {
      self[key] = values[index]
    }
  }
}
