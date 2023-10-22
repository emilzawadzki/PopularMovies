//
//  PopularMoviesResponseModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

struct PopularMoviesResponseModel: Codable {
	var page: Int
	var results: [MovieModel]
	
}
