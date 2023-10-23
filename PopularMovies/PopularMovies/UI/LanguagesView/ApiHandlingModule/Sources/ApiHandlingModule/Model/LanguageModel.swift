//
//  LanguageModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 23/10/2023.
//

import Foundation

public struct LanguageModel: Identifiable, Codable {
	public var id: String {
		return iso_639_1
	}
	public var name: String
	public var english_name: String
	public var iso_639_1: String
}
