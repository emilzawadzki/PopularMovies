//
//  MovieDetailsModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

struct MovieDetailsModel: Identifiable, Codable {
	var id: Int
	var overview: String
	var release_date: String
}
