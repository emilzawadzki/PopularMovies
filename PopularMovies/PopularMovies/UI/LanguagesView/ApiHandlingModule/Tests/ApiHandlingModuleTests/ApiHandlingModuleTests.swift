import XCTest
@testable import ApiHandlingModule

final class ApiHandlingModuleTests: XCTestCase {
	
	func testPopularMovies() async throws {
		
		let fetcher = DataFetcher()
		let moviesData = try? await fetcher.getPopularMoviesData(page: 1)
		let moviesModel = fetcher.moviesListModel(from: moviesData)
		
		XCTAssertNotNil(moviesModel)
		XCTAssertGreaterThan(moviesModel!.count, 0)
	}
	
	func testMovieDetails() async throws {
		
		let fetcher = DataFetcher()
		let movieData = try? await fetcher.getMovieDetails(movieID: 299054)
		let overviewModel = fetcher.movieOverviewModel(from: movieData)
		
		XCTAssertNotNil(overviewModel)
		
		let releaseDateModel = fetcher.movieOverviewModel(from: movieData)
		
		XCTAssertNotNil(releaseDateModel)
		
		let languagesModel = fetcher.movieOverviewModel(from: movieData)
		
		XCTAssertNotNil(languagesModel)
		XCTAssertGreaterThan(languagesModel!.count, 0)
	}
	
	func testFavourites() throws {
		
		let fetcher = DataFetcher()
		
		let fakeMovieID = -12
		XCTAssertFalse(fetcher.isMovieFavourite(movieID: fakeMovieID))
		
		fetcher.setMovieAsFavourite(movieID: fakeMovieID, isFavourite: true)
		XCTAssertTrue(fetcher.isMovieFavourite(movieID: fakeMovieID))
		
		fetcher.setMovieAsFavourite(movieID: fakeMovieID, isFavourite: false)
		XCTAssertFalse(fetcher.isMovieFavourite(movieID: fakeMovieID))
		
	}
}
