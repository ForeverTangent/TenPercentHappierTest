//
//  MeditationItem.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import SwiftUI

struct MeditationItemView: View {
	var lessonTitle: String
	var instructor: String
    var body: some View {
		HStack {
			Button(action: {
				print("Edit button was tapped")
			}) {
				Image(systemName: "pencil")
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
		MeditationItemView(lessonTitle: "Guidelines👍", instructor: "Instructor")
    }
}
