//
//  DetailMovieMapper.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 05/11/20.
//

import Foundation

final class DetailMovieMapper {
  
  static func mapDetailMovieResponseToDomains(movieResponse: DetailMovieResponse, creditResponse: CreditResponse) -> DetailMovieModel {
    let genres = mapGenresResponseToDomains(input: movieResponse)
    let casts = mapCastsResponseToDomains(input: creditResponse)
    let crews = mapCrewsResponseToDomains(input: creditResponse)
    
    return DetailMovieModel(id: movieResponse.id, genres: genres, homepage: movieResponse.homepage, imdbID: movieResponse.imdbId, originalLanguage: movieResponse.originalTitle, originalTitle: movieResponse.title, overview: movieResponse.overview, popularity: movieResponse.popularity, posterPath: movieResponse.posterPath, backdropPath: movieResponse.backdropPath, releaseDate: movieResponse.releaseDate, runtime: movieResponse.runtime, status: movieResponse.status, tagline: movieResponse.tagline, title: movieResponse.title, video: movieResponse.video, voteAverage: movieResponse.voteAverage, voteCount: movieResponse.voteCount, casts: casts, crews: crews)
  }
  
  static func mapGenresResponseToDomains(input response: DetailMovieResponse) -> [GenreModel] {
    return response.genres.map { GenreModel(id: $0.id, name: $0.name) }
  }
  
  static func mapCastsResponseToDomains(input response: CreditResponse) -> [CastModel] {
    return response.cast.map { CastModel(id: $0.id, character: $0.character, name: $0.name, order: 0, profilePath: $0.profilePath)}
  }
  
  static func mapCrewsResponseToDomains(input response: CreditResponse) -> [CrewModel] {
    return response.crew.map { CrewModel(id: $0.id, job: $0.job, name: $0.name, departement: $0.department, order: 0)}
  }
}
