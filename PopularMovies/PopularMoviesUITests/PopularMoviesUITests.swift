//
//  PopularMoviesUITests.swift
//  PopularMoviesUITests
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import XCTest

final class PopularMoviesUITests: XCTestCase {
	
	var app: XCUIApplication!
	var moviesListCells: XCUIElementQuery!
	var onErrorRetryButton: XCUIElement!
	var favouritesToggle: XCUIElement!

    override func setUpWithError() throws {
		app = XCUIApplication()
		moviesListCells = app.tables.cells
		onErrorRetryButton = app.buttons["Retry"]
		favouritesToggle = app.switches.firstMatch
		
		app.launch()
    }

    override func tearDownWithError() throws {
		favouritesToggle = nil
		onErrorRetryButton = nil
		moviesListCells = nil
		app = nil
    }

    func testFavouritesToggle() throws {
		
		_ = moviesListCells.element.waitForExistence(timeout: 3)
		
		let moviesCount = moviesListCells.count
		
		favouritesToggle.tap()
		_ = moviesListCells.element.waitForExistence(timeout: 1)
		
		let favouritesMoviesCount = moviesListCells.count
		XCTAssertGreaterThan(moviesCount, favouritesMoviesCount)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
