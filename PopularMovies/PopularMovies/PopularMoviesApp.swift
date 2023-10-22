//
//  PopularMoviesApp.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI

@main
struct PopularMoviesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
