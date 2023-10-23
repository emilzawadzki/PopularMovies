//
//  MovieDetailsModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

struct MovieDetailsModel: Codable {
	var overview: String
	var release_date: String
	var spoken_languages: [LanguageModel]
}
