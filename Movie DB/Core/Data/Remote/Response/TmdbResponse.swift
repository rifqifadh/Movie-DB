//
//  TMDbResponse.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 31/10/20.
//

import Foundation

struct Response<T: Decodable>: Decodable {
  
  let page: Int?
  let results: T
}
