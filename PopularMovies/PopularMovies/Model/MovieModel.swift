//
//  MovieModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

struct MovieModel: Identifiable, Codable {
	//TODO: remove unused
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
	
	var imagePath: String {
		return "https://image.tmdb.org/t/p/original/\(poster_path)"
	}
	
#if DEBUG
static let example = MovieModel(id: 9, adult: false, genre_ids: [0], original_language: "en", original_title: "title", overview: "lorem ipsum", popularity: 6.0, poster_path: "path.jpg", release_date: "today", title: "title", video: true, vote_average: 6.0, vote_count: 1)
#endif
}
