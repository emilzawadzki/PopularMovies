//
//  DetailsViewModel.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI

class DetailsViewModel: ObservableObject {
	
	private let dataFetcher = DataFetcher()
	@State var movieInfo: MovieModel
	@Published var movieOverview: String = ""
	@Published var movieReleaseDate: String = ""
	@Published var isFavourite = false {
		didSet {
			dataFetcher.setMovieAsFavourite(movieID: movieInfo.id, isFavourite: isFavourite)
		}
	}
	var languages: [LanguageModel] = []
	
	init(movieInfo: MovieModel) {
		self.movieInfo = movieInfo
	}
	
	@MainActor
	func getMovieDetails() async {
		//TODO: change
		isFavourite = dataFetcher.isMovieFavourite(movieID: movieInfo.id)
		let group = DispatchGroup()
		var overview = ""
		var releaseDate = ""
		var languages: [LanguageModel] = []
		group.enter()
		Task(priority: .background) {
			let moviesDetailsData = try? await dataFetcher.getMovieDetails(movieID: movieInfo.id)
			overview = dataFetcher.movieOverviewModel(from: moviesDetailsData) ?? ""
			group.leave()
		}
		group.enter()
		Task(priority: .background) {
			let moviesDetailsData = try? await dataFetcher.getMovieDetails(movieID: movieInfo.id)
			releaseDate = dataFetcher.movieReleaseDateModel(from: moviesDetailsData) ?? ""
			group.leave()
		}
		group.enter()
		Task(priority: .background) {
			let moviesDetailsData = try? await dataFetcher.getMovieDetails(movieID: movieInfo.id)
			languages = dataFetcher.movieLangugesModel(from: moviesDetailsData) ?? []
			group.leave()
		}
		
		group.notify(queue: .main) {
			self.movieReleaseDate = releaseDate
			self.movieOverview = overview
			self.languages = languages
		}
	}
}
