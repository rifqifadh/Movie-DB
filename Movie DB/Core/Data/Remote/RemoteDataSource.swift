//
//  RemoteDataSource.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDataSourceProtocol: class {
  
  func getDiscoverMovies() -> AnyPublisher<Response<[MovieResponse]>, Error>
}

final class RemoteDataSource: NSObject {
  private override init() {}
  
  static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  // MARK: GET Movies Now Playing
  func getDiscoverMovies() -> AnyPublisher<Response<[MovieResponse]>, Error> {
    return Future<Response<[MovieResponse]>, Error> { completion in
      if let url = URL(string: Endpoints.Gets.discoverMovies.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: Response<[MovieResponse]>.self) { response in
            switch response.result {
            case .success(let results):
              completion(.success(results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
