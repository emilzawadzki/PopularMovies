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
	
	@State private var selectedMovie: MovieModel?
	@State private var showingSelectedMovie: Bool = false

    var body: some View {
		NavigationView {
			VStack {
				List (moviesViewModel.onlyFavourites ? moviesViewModel.favouriteMovies : moviesViewModel.movies) { movie in
					Button(action: {
						selectedMovie = movie
						showingSelectedMovie = true
					}, label: {
						MovieListItemView(movie: movie, isFavourite: moviesViewModel.isMovieFavourite(movieID: movie.id))
					})
					.onAppear() {
						moviesViewModel.loadMoreContentIfNeeded(currentItem: movie)
					}
				}
				NavigationLink(isActive: $showingSelectedMovie) {
					if let selectedMovie {
						DetailsView(detailsViewModel: DetailsViewModel(movieInfo: selectedMovie))
					} else {
						EmptyView()
					}
				} label: {}
					.isDetailLink(false)
					.hidden()
				
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
			.onAppear {
				moviesViewModel.onFirstAppear()
			}
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
