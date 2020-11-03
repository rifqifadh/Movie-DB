//
//  MovieEntity.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 02/11/20.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
  
  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var overview: String = ""
  @objc dynamic var voteAverage: Double = 0
  @objc dynamic var posterPath: String = ""
  @objc dynamic var backdropPath: String = ""
  @objc dynamic var releaseDate: String = ""
  
  override class func primaryKey() -> String? {
    return "id"
  }
  
}
