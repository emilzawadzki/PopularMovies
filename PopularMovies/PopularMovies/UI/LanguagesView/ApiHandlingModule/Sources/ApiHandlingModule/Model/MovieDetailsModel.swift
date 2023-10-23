//
//  MovieDetailsModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

public struct MovieDetailsModel: Codable {
	public var overview: String
	public var release_date: String
	public var spoken_languages: [LanguageModel]
}
