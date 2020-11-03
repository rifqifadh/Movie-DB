//
//  TmdbService.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation
import Moya

/// This Method is currently disabled due to lack of testing
enum TmdbService {
  case movieNowPlaying
}

extension TmdbService: TargetType {
  var baseURL: URL { return URL(string: TMDB.tmdbURL)! }
  
  var path: String {
    switch self {
    case .movieNowPlaying:
      return "movie/now_playing"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .movieNowPlaying:
      return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    let authParams = ["api_key": TMDB.apiKey]
    
    switch self {
    case .movieNowPlaying:
      return .requestParameters(parameters: authParams, encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}

