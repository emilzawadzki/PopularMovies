//
//  PopularMoviesTests.swift
//  PopularMoviesTests
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import XCTest
@testable import PopularMovies

final class PopularMoviesTests: XCTestCase {
	
	var viewModel: PopularMoviesViewModel!

    override func setUpWithError() throws {
        viewModel = PopularMoviesViewModel()
    }

    override func tearDownWithError() throws {
		viewModel = nil
    }

    func testGetMovies() async throws {
		XCTAssertEqual(viewModel.movies.count, 0)
		await viewModel.getPopularMovies()
		XCTAssertGreaterThan(viewModel.movies.count, 0)
    }
	
	func testAppearCondition() throws {
		XCTAssertFalse(viewModel.didViewAlreadyAppeared)
		viewModel.onFirstAppear()
		XCTAssertTrue(viewModel.didViewAlreadyAppeared)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
