//
//  MovieModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

struct MovieModel: Identifiable, Codable {
	var id: Int
	var overview: String
	var poster_path: String
	var release_date: String
	var title: String
	
	var imagePath: String {
		return "https://image.tmdb.org/t/p/original/\(poster_path)"
	}
	
#if DEBUG
static let example = MovieModel(id: 9, overview: "lorem ipsum", poster_path: "path.jpg", release_date: "today", title: "title")
#endif
}
