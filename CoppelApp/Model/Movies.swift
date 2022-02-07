//
//  Movies.swift
//  CoppelApp
//
//  Created by Jose Cadena on 06/02/22.
//

import UIKit
struct Movies: Codable {
    var page: Int?
    var results: [Movie]?
}

struct Movie: Codable {
    var poster_path: String?
    var adult: Bool?
    var overview: String?
    var release_date: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
    var backdrop_path: String?
    var popularity: Float?
    var vote_count: Int?
    var video: Bool?
    var vote_average: Float?
}
