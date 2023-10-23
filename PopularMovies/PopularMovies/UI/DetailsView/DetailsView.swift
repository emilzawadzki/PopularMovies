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
					Spacer()
					AsyncImage(url: URL(string: detailsViewModel.movieInfo.imagePath)) { image in
						image
							.resizable()
							.aspectRatio(contentMode: .fit)
					} placeholder: {
						Color.gray
					}
					.frame(width: 200.0, height: 300.0, alignment: .center)
					Spacer(minLength: 40)
					Group {
						Text("Overview:")
							.font(.title2)
						Text($detailsViewModel.movieOverview.wrappedValue)
							.font(.title3)
							.multilineTextAlignment(.center)
						Spacer(minLength: 40)
						Text("Release date:")
							.font(.title2)
						Text($detailsViewModel.movieReleaseDate.wrappedValue)
							.font(.title3)
						Spacer(minLength: 40)
					}
					Button {
						showingModal.toggle()
					} label: {
						ZStack {
							Text("Show languages")
						}.padding(10)
					}
					.background(RoundedRectangle(
						cornerRadius: 10,
						style: .continuous
						)
						.fill(.black)
					)
					.foregroundColor(.white)
					
					Spacer(minLength: 40)
					Toggle(isOn: $detailsViewModel.isFavourite) {
						Text("Is favourite")
							.font(.title2)
					}
				}
				.padding(30)
				.sheet(isPresented: $showingModal, content: { LanguagesView(languages:detailsViewModel.languages) })
				.onAppear() {
					Task {
						await detailsViewModel.getMovieDetails()
					}
				}
			}
			if detailsViewModel.loaderVisible {
				ZStack {
					Color(red: 0, green: 0, blue: 0, opacity: 0.5).edgesIgnoringSafeArea(.all)
					ProgressView()
				}
			}
		}
	}
	
}
