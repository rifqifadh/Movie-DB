//
//  LocaleDataSource.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 02/11/20.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
  
  func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error>
  func addMovieToFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
  func deleteMovieFromFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
  func movieIsFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
  
  private let realm: Realm?
  private init(realm: Realm?) {
    self.realm = realm
  }
  
  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func getFavoriteMovies() -> AnyPublisher<[MovieEntity], Error> {
    return Future<[MovieEntity], Error> { completion in
      if let realm = self.realm {
        let movies: Results<MovieEntity> = {
          realm.objects(MovieEntity.self)
            .sorted(byKeyPath: "id", ascending: true)
        }()
        completion(.success(movies.toArray(ofType: MovieEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func addMovieToFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(movie, update: .modified)
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func deleteMovieFromFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          let movieEntity = realm.objects(MovieEntity.self).filter("id == \(movie.id)")
          try realm.write {
            realm.delete(movieEntity)
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  func movieIsFavorite(from movie: MovieEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        let movies = realm.objects(MovieEntity.self).filter("id == \(movie.id)")
        if !movies.isEmpty {
          completion(.success(true))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}

extension Results {
  
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0..<count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
