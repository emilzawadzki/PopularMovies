//
//  PopularMoviesViewModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI
import ApiHandlingModule

class PopularMoviesViewModel: ObservableObject {
	
	private let dataFetcher = DataFetcher()
	
	@Published var movies: [MovieModel] = []
	
	var favouriteMovies: [MovieModel] {
		return filterFavourites(movies: movies)
	}
	@Published var onlyFavourites = false
	@Published var loaderVisible = true
	
	@Published var showError = false
	
	private var downloadedPageIndex = 1
	
	private var didViewAlreadyAppeared = false
	
	func onFirstAppear() {
		guard !didViewAlreadyAppeared else {
			return
		}
		didViewAlreadyAppeared.toggle()
		loaderVisible = true
		Task {
			await getPopularMovies()
			DispatchQueue.main.async() {
				self.loaderVisible = false
			}
		}
	}
	
	@MainActor
	func getPopularMovies() async {
		let moviesData = try? await dataFetcher.getPopularMoviesData(page: downloadedPageIndex)
		let moviesModel = dataFetcher.moviesListModel(from: moviesData)
		guard let movies = moviesModel else {
			showError = true
			return
		}
		self.movies.append(contentsOf: movies)
	}
	
	func filterFavourites(movies: [MovieModel]) -> [MovieModel] {
		return movies.filter{ isMovieFavourite(movieID: $0.id) }
	}
	
	func isMovieFavourite(movieID: Int) -> Bool {
		return dataFetcher.isMovieFavourite(movieID: movieID)
	}
	
	func loadMoreContentIfNeeded(currentItem: MovieModel) {
		guard !onlyFavourites else {
			return
		}
		if movies.last?.id == currentItem.id {
			downloadedPageIndex += 1
			Task {
				await getPopularMovies()
			}
		}
		
	}
	
	func onRetryTapped() {
		loaderVisible = true
		showError = false
		Task {
			await getPopularMovies()
			DispatchQueue.main.async() {
				self.loaderVisible = false
			}
		}
	}
}
