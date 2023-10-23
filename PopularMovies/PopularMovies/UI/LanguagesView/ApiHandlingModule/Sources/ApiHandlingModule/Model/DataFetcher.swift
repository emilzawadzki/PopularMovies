//
//  DataFetcher.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

@available(iOS 15.0, *)
public class DataFetcher {
	private var session = URLSession.shared
	private let userDefaults = UserDefaults()
	
	private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OTU4YTlmYTA4MWM5NzVhZGM0NDA4Yzc4ZGU4NWM4YiIsInN1YiI6IjY1MzFiNDE2OWFjNTM1MDBmZjY3MWFhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.24nsimcIMvxyYCUdWvVEXfbxL6SSFELp6vQarXh6658"
	private let apiPath = "https://api.themoviedb.org/3/"
	private let imageApiPath = "https://image.tmdb.org/t/p/original/"
	
	public init() {
		
	}
	
	public func getPopularMoviesData(page: Int = 1) async throws -> Data? {
		guard let url = URL(string: "\(apiPath)discover/movie?include_adult=false&include_video=false&language=en-US&page=\(page)&sort_by=popularity.desc") else {
			return nil
		}
		do {
			var request = URLRequest(url: url)
			request.addValue("application/json", forHTTPHeaderField: "accept")
			request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
			
			let (data, _) = try await session.data(for: request)
			return data
		} catch {
			// Error handled in ViewModel class
			return nil
		}
	}
	
	public func getMovieDetails(movieID: Int) async throws -> Data? {
		guard let url = URL(string: "\(apiPath)movie/\(movieID)?language=en-US") else {
			return nil
		}
		do {
			var request = URLRequest(url: url)
			request.addValue("application/json", forHTTPHeaderField: "accept")
			request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
			
			let (data, _) = try await session.data(for: request)
			return data
		} catch {
			// Error handled in ViewModel class
			return nil
		}
	}
	
	public func moviesListModel(from data: Data?) -> [MovieModel]? {
		guard let jsonData = data else { return nil }
		let decoder = JSONDecoder()
		let moviesModel = try? decoder.decode(PopularMoviesResponseModel.self, from: jsonData)
		
		return moviesModel?.results
	}
	
	public func movieOverviewModel(from data: Data?) -> String? {
		guard let jsonData = data else { return nil }
		let decoder = JSONDecoder()
		let moviesModel = try? decoder.decode(MovieDetailsModel.self, from: jsonData)
		
		return moviesModel?.overview
	}
	
	public func movieLangugesModel(from data: Data?) -> [LanguageModel]? {
		guard let jsonData = data else { return nil }
		let decoder = JSONDecoder()
		let moviesModel = try? decoder.decode(MovieDetailsModel.self, from: jsonData)
		
		return moviesModel?.spoken_languages
	}
	
	public func movieReleaseDateModel(from data: Data?) -> String? {
		guard let jsonData = data else { return nil }
		let decoder = JSONDecoder()
		let moviesModel = try? decoder.decode(MovieDetailsModel.self, from: jsonData)
		
		return moviesModel?.release_date
	}
	
	private let favouritesKey = "favouritesKey"
	public func isMovieFavourite(movieID: Int) -> Bool {
		if let favouritesList = userDefaults.object(forKey: favouritesKey) as? [Int] {
			return favouritesList.contains(movieID)
		}
		return false
	}
	
	public func setMovieAsFavourite(movieID: Int, isFavourite: Bool) {
		if var favouritesList = userDefaults.object(forKey: favouritesKey) as? [Int] {
			if isFavourite {
				favouritesList.append(movieID)
			} else {
				favouritesList.removeAll(where: { $0 == movieID})
			}
			userDefaults.set(favouritesList, forKey: favouritesKey)
		} else if isFavourite {
			let favouritesList = [movieID]
			userDefaults.set(favouritesList, forKey: favouritesKey)
		}
	}
	
	
}
