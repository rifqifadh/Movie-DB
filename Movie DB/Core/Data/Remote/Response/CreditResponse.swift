//
//  CreditResponse.swift
//  Movie DB
//
//  Created by Rifqi Fadhlillah on 05/11/20.
//

import Foundation

// MARK: - CreditResponse
struct CreditResponse: Codable {
  let id: Int
  let cast: [CastResponse]
  let crew: [CrewResponse]
}

// MARK: - Cast
struct CastResponse: Codable {
  let character, name: String
  let id: Int
//  let order: Int
  let profilePath: String?
}

// MARK: - Crew
struct CrewResponse: Codable {
  let id: Int
  let department, job, name: String
}
