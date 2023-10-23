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
									.font(.title)
								Text("(\(language.name))")
									.font(.title)
							}
							Spacer()
						}
					}
					
					Button("Close") {
						dismiss()
					}
					.font(.title)
					.padding()
				}
				.padding(20)
			}
		}
	}
}
