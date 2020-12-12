//
//  TMDBServices.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 05/11/20.
//

import Foundation
import Combine

class TMDBServices {
  
  static private let decoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    jsonDecoder.dateDecodingStrategy = .iso8601
    return jsonDecoder
  }()
  
  static private func makeUrl(endpoint: Endpoints, params: [String: String]? = nil) -> URL {
    var component = URLComponents(url: TMDB.tmdbURL.appendingPathComponent(endpoint.path()), resolvingAgainstBaseURL: false)!
    var queryItems = [URLQueryItem(name: "api_key", value: TMDB.apiKey)]
    
    if let params = params {
      queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
    }
    component.queryItems = queryItems
    
    return component.url!
  }
  
  static private var session: URLSession = {
     let config = URLSessionConfiguration.default
      config.urlCache = URLCache.shared
      config.waitsForConnectivity = true
      config.requestCachePolicy = .returnCacheDataElseLoad
      return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
  }()
  
  static func fetch<T: Codable>(from endpoint: Endpoints, params: [String: String]? = nil, response: T.Type) -> AnyPublisher<T, Error> {
    let request = URLRequest(url: makeUrl(endpoint: endpoint, params: params))
    
    return session.dataTaskPublisher(for: request)
      .map { $0.data }
      .decode(type: T.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}
