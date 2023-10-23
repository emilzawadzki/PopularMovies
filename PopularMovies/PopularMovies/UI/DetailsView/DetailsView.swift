//
//  DetailsView.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI

struct DetailsView: View {
	
	@StateObject var detailsViewModel: DetailsViewModel
	@State private var showingModal = false
	
	var body: some View {
		ZStack {
			ScrollView {
				VStack {
					Text(detailsViewModel.movieInfo.title)
						.font(.title)
					AsyncImage(url: URL(string: detailsViewModel.movieInfo.imagePath)) { image in
						image
							.resizable()
							.aspectRatio(contentMode: .fit)
					} placeholder: {
						Color.gray
					}
					.frame(width: 180.0, height: 180.0, alignment: .center)
					Spacer()
					Group {
						Text("Overview:")
							.font(.title2)
						Text($detailsViewModel.movieOverview.wrappedValue)
							.font(.title3)
						Spacer()
						Text("Release date:")
							.font(.title2)
						Text($detailsViewModel.movieReleaseDate.wrappedValue)
							.font(.title3)
						Spacer()
					}
					Button("Show languages") {
						showingModal.toggle()
					}
					Spacer()
					Toggle(isOn: $detailsViewModel.isFavourite) {
						Text("Is favourite")
							.font(.title2)
					}
					.frame(alignment: .center)
				}
				.padding(20)
				.sheet(isPresented: $showingModal, content: { LanguagesView(languages:detailsViewModel.languages) })
				.onAppear() {
					Task {
						await detailsViewModel.getMovieDetails()
					}
				}
			}
		}
	}
	
}
