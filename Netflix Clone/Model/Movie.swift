//
//  Movie.swift
//  Netflix Clone
//
//  Created by HAMZA on 14/6/2022.
//

import Foundation


struct TrendingMoviesTv: Codable {
    let results: [MovieTv]
}

struct MovieTv: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
