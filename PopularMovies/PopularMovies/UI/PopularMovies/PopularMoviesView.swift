//
//  PopularMoviesView.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI
import CoreData

struct PopularMoviesView: View {
    @Environment(\.managedObjectContext) private var viewContext

	@StateObject var moviesViewModel = PopularMoviesViewModel()

    var body: some View {
		VStack {
			List (moviesViewModel.onlyFavourites ? moviesViewModel.favouriteMovies : moviesViewModel.movies) { movie in
				MovieListItemView(movie: movie)
			}
			.refreshable {
				await moviesViewModel.getPopularMovies()
			}
			
			HStack(alignment: .top, spacing: 20) {
				Toggle (isOn: $moviesViewModel.onlyFavourites) {
					Text("Favourites")
						.frame(maxWidth: .infinity, alignment: .trailing)
				}
				Button("Get Movies") {
					Task {
						await moviesViewModel.getPopularMovies()
					}
				}
				.buttonStyle(.borderedProminent)
				.clipShape(RoundedRectangle(cornerRadius: 10))
			}
			.padding()
		}
    }

    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
		PopularMoviesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
