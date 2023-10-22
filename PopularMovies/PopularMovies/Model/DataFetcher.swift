//
//  DataFetcher.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

class DataFetcher {
	var session = URLSession.shared
	
	private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTU4YTlmYTA4MWM5NzVhZGM0NDA4Yzc4ZGU4NWM4YiIsInN1YiI6IjY1MzFiNDE2OWFjNTM1MDBmZjY3MWFhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.24nsimcIMvxyYCUdWvVEXfbxL6SSFELp6vQarXh6658"
	private let apiPath = "https://api.themoviedb.org/3/"
	private let imageApiPath = "https://image.tmdb.org/t/p/original/"
	
	func getPopularMoviesData(page: Int = 1) async throws -> Data? {
		guard let url = URL(string: "\(apiPath)discover/movie?include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=popularity.desc") else {
			//TODO: handle error
			return nil
		}
		do {
			var request = URLRequest(url: url)
			request.addValue("application/json", forHTTPHeaderField: "accept")
			request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
			
			let (data, _) = try await URLSession.shared.data(for: request)
			return data
		} catch {
			//TODO: handle error
			return nil
		}
	}
	
	func serachMovies(query: String) async throws -> Data? {
		guard let url = URL(string: "\(apiPath)search/movie?query=\(query)&include_adult=false&language=en-US&page=1") else {
			//TODO: handle error
			return nil
		}
		do {
			var request = URLRequest(url: url)
			request.addValue("application/json", forHTTPHeaderField: "accept")
			request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
			
			let (data, _) = try await URLSession.shared.data(for: request)
			return data
		} catch {
			//TODO: handle error
			return nil
		}
	}
	
	func getMovieDetails(movieID: Int) async throws -> Data? {
		guard let url = URL(string: "\(apiPath)movie/\(movieID)?language=en-US") else {
			//TODO: handle error
			return nil
		}
		do {
			var request = URLRequest(url: url)
			request.addValue("application/json", forHTTPHeaderField: "accept")
			request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
			
			let (data, _) = try await URLSession.shared.data(for: request)
			return data
		} catch {
			//TODO: handle error
			return nil
		}
	}
	
	func downloadImage(posterPath: String) async throws -> Data? {
		guard let url = URL(string: "\(imageApiPath)\(posterPath)") else {
			//TODO: handle error
			return nil
		}
		do {
			let request = URLRequest(url: url)
			
			let (data, _) = try await URLSession.shared.data(for: request)
			return data
		} catch {
			//TODO: handle error
			return nil
		}
	}
	
	func moviesListModel(from data: Data?) -> [MovieModel]? {
		guard let jsonData = data else { return nil }
		let decoder = JSONDecoder()
		let moviesModel = try? decoder.decode(PopularMoviesResponseModel.self, from: jsonData)
		
		return moviesModel?.results
	}
	
	func movieDetailsModel(from data: Data?) -> MovieDetailsModel? {
		guard let jsonData = data else { return nil }
		let decoder = JSONDecoder()
		let moviesModel = try? decoder.decode(MovieDetailsModel.self, from: jsonData)
		
		return moviesModel
	}
	
	
}
