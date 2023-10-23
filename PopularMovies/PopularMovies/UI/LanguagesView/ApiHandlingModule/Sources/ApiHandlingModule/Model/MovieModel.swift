//
//  MovieModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

public struct MovieModel: Identifiable, Codable {
	public var id: Int
	public var overview: String
	public var poster_path: String
	public var release_date: String
	public var title: String
	
	public var imagePath: String {
		return "https://image.tmdb.org/t/p/original/\(poster_path)"
	}
	
#if DEBUG
public static let example = MovieModel(id: 9, overview: "lorem ipsum", poster_path: "path.jpg", release_date: "today", title: "title")
#endif
}
