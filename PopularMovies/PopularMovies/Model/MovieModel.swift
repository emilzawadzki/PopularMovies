//
//  MovieModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

struct MovieModel: Identifiable, Codable {
	var id: Int
	var adult: Bool
	var genre_ids: [Int]
	var backdrop_path: String?
	var original_language: String
	var original_title: String
	var overview: String
	var popularity: Double
	var poster_path: String
	var release_date: String
	var title: String
	var video: Bool
	var vote_average: Double
	var vote_count: Int
}
