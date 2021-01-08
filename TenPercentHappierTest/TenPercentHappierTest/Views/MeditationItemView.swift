//
//  MeditationItem.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import SwiftUI

/**
Meditations Item View
*/
struct MeditationItemView: View {
	@ObservedObject var imageViewModel: MeditationItemImageViewModel
	
	var lessonTitle: String
	var instructor: String

	static var defaultImage = UIImage(named: "NewsIcon")

	var body: some View {
		HStack {
			Button(action: {
				print("Edit button was tapped")
			}) {
				Image(uiImage: imageViewModel.image)
					.resizable()
					.frame(width: 50.0, height: 50.0)

			}
			VStack(alignment: .leading) {
				Text(lessonTitle)
					.fontWeight(.medium)
				Text(instructor)
					.fontWeight(.light)
			}
			Spacer()
		}
		.padding(.all)
		.frame(height: 50.0)
	}
}


struct MeditationItem_Previews: PreviewProvider {
	static var previews: some View {
		MeditationItemView(imageViewModel:
							MeditationItemImageViewModel(urlString: "https://production.assets.changecollective.com/uploads/meditation/image/2/topicTile_begin.png"),
						   lessonTitle: "Lession 1",
						   instructor: "Guru")
	}
}
