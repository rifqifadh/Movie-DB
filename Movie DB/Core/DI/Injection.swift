//
//  Injection.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  func provideRepository() -> TmdbRepository {
    let realm = try? Realm()
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    
    return TmdbRepository.sharedInstance(remote, locale)
  }
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideDetailMovie(movie: MovieModel) -> DetailMovieUseCase {
    let repository = provideRepository()
    return DetailMovieInteractor(repository: repository, movie: movie)
  }
  
  func provideFavoriteMovies() -> FavoriteMoviesUseCase {
    let repository = provideRepository()
    return FavoriteMoviesInteractor(repository: repository)
  }
}
