//
//  PopularMoviesView.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI
import CoreData

struct PopularMoviesView: View {

	@StateObject var moviesViewModel = PopularMoviesViewModel()
	
	@State private var selectedMovie: MovieModel?
	@State private var showingSelectedMovie: Bool = false

    var body: some View {
		NavigationView {
			ZStack {
				VStack {
					HStack(alignment: .top, spacing: 20) {
						Toggle (isOn: $moviesViewModel.onlyFavourites) {
							Text("Favourites only")
								.frame(maxWidth: .infinity, alignment: .leading)
						}
					}
					.padding()
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
				}
				if moviesViewModel.loaderVisible {
					ZStack {
						Color(red: 0, green: 0, blue: 0, opacity: 0.5).edgesIgnoringSafeArea(.all)
						ProgressView()
					}
				}
				
				if moviesViewModel.showError {
					ZStack {
						Color(red: 0, green: 0, blue: 0, opacity: 0.5).edgesIgnoringSafeArea(.all)
						VStack {
							Text("Error: loading movies list failed")
								.frame(maxWidth: .infinity, alignment: .center)
								.foregroundColor(.white)
							Button {
								moviesViewModel.onRetryTapped()
							} label: {
								ZStack {
									Text("Retry")
								}.padding(10)
							}
							.background(RoundedRectangle(
								cornerRadius: 10,
								style: .continuous
								)
								.fill(.black)
							)
							.foregroundColor(.white)
						}
						.padding(40)
					}
				}
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
		PopularMoviesView()
    }
}
