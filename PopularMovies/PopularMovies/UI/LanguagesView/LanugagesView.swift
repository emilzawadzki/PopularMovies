//
//  LanugagesView.swift
//  PopularMovies
//
//  Created by Emil Zawadzki on 23/10/2023.
//

import SwiftUI

struct LanguagesView: View {
	@Environment(\.dismiss) var dismiss
	
	var languages: [LanguageModel]

	var body: some View {
		ZStack {
			ScrollView {
				VStack {
					Text("Spoken languages:")
						.font(.title)
					Spacer()
					
					ForEach( languages, id: \.iso_639_1) { language in
						VStack {
							HStack(alignment: .top) {
								Text(language.english_name)
									.font(.title2)
								Text("(\(language.name))")
									.font(.title2)
							}
							Spacer(minLength: 20)
						}
					}
					
					Spacer(minLength: 40)
					
					Button {
						dismiss()
					} label: {
						ZStack {
							Text("Close")
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
				.padding(20)
			}
		}
	}
}
