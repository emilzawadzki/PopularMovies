//
//  DataFetcher.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import Foundation

class DataFetcher {
	var session = URLSession.shared
	
	func getMoviesData(from url: URL) async throws -> Data? {
		do {
			let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
			return data
		} catch {
			return nil
		}
	}
	
	
}
