//
//  MovieListItemView.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 22/10/2023.
//

import SwiftUI
import ApiHandlingModule

struct MovieListItemView: View {
	let movie: MovieModel
	let isFavourite: Bool
	
	private let dataFetcher = DataFetcher()
	
	var body: some View {
		HStack(alignment: .center, spacing: 20) {
			AsyncImage(url: URL(string: movie.imagePath)) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
			} placeholder: {
				Color.gray
			}
			.frame(width: 80.0, height: 120.0, alignment: .center)
			VStack(alignment: .leading) {
				Text(movie.title)
					.font(.title2)
				if isFavourite {
					Text("favourite")
						.padding(EdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5))
						.overlay(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)).stroke(Color.black, lineWidth: 3))
						.font(.caption)
				}
			}
		}
	}
}

struct MovieListItemView_Previews: PreviewProvider {
	static var previews: some View {
		MovieListItemView(movie: MovieModel.example, isFavourite: true)
	}
}
