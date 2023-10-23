//
//  LanguageModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 23/10/2023.
//

import Foundation

struct LanguageModel: Identifiable, Codable {
	var id: String {
		return iso_639_1
	}
	var name: String
	var english_name: String
	var iso_639_1: String
}
