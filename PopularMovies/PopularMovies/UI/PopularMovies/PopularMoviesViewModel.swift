//
//  PopularMoviesViewModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI

class PopularMoviesViewModel: ObservableObject {
	
	@Published var movies: [MovieModel] = []
	
	var favouriteMovies: [MovieModel] {
		return filterFavourites(movies: movies)
	}
	@Published var onlyFavourites = false
	
	@MainActor
	func getPopularMovies() async {
		let dataFetcher = DataFetcher()
		let moviesData = try? await dataFetcher.getPopularMoviesData()
		let moviesModel = dataFetcher.moviesListModel(from: moviesData)
		guard let movies = moviesModel else { return }
		self.movies = movies
	}
	
	func filterFavourites(movies: [MovieModel]) -> [MovieModel] {
		//TODO: change
		return movies.filter{ $0.adult }
	}
}
