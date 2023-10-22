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
	
	private var downloadedPageIndex = 1
	
	@MainActor
	func getPopularMovies() async {
		let dataFetcher = DataFetcher()
		let moviesData = try? await dataFetcher.getPopularMoviesData(page: downloadedPageIndex)
		let moviesModel = dataFetcher.moviesListModel(from: moviesData)
		guard let movies = moviesModel else { return }
		self.movies.append(contentsOf: movies)
	}
	
	func filterFavourites(movies: [MovieModel]) -> [MovieModel] {
		//TODO: change
		return movies.filter{ $0.adult }
	}
	
	func loadMoreContentIfNeeded(currentItem: MovieModel) {
		if movies.last?.id == currentItem.id {
			downloadedPageIndex += 1
			Task {
				await getPopularMovies()
			}
		}
		
	}
}
