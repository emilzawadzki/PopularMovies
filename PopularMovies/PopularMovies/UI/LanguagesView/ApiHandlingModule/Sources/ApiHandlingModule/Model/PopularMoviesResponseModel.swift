//
//  PopularMoviesResponseModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

public struct PopularMoviesResponseModel: Codable {
	public var page: Int
	public var results: [MovieModel]
	
}
