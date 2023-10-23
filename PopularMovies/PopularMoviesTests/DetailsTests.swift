//
//  DetailsTests.swift
//  PopularMoviesTests
//
//  Created by Emil Zawadzki on 23/10/2023.
//

import XCTest
@testable import PopularMovies
@testable import ApiHandlingModule

final class DetailsTests: XCTestCase {
	
	var viewModel: DetailsViewModel!

	override func setUpWithError() throws {
		var mockedModel = MovieModel.example
		mockedModel.id = 299054
		viewModel = DetailsViewModel(movieInfo: mockedModel)
	}

	override func tearDownWithError() throws {
		viewModel = nil
	}

	func testGetDetails() async throws {
		XCTAssertEqual(viewModel.movieOverview, "")
		XCTAssertEqual(viewModel.movieReleaseDate, "")
		XCTAssertEqual(viewModel.languages.count, 0)
		await viewModel.getMovieDetails()
		sleep(2)
		XCTAssertGreaterThan(viewModel.movieOverview.count, 0)
		XCTAssertGreaterThan(viewModel.movieReleaseDate.count, 0)
		XCTAssertGreaterThan(viewModel.languages.count, 0)
	}

	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}

}
