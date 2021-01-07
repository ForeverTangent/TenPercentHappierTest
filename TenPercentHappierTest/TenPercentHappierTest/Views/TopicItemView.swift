//
//  TopicItem.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21./Users/staque/Development/GitHub/TenPercentHappierTest/TenPercentHappierTest/TenPercentHappierTest/TopicsView.swift:28:12: Cannot convert value of type '[Topic]?' to expected argument type 'Range<Int>'
//

import SwiftUI

struct TopicItemView: View {

	var uuid: String
	var topicTitle: String
	var numberOfMeditations: Int
	var tabColor: Color

	var body: some View {

		GeometryReader { geometry in
			ZStack{
				HStack {
					RoundedRectangle(cornerRadius: 5.0)
						.frame(height: 80.0)
						.overlay(
							RoundedRectangle(cornerRadius: 5.0)
								.stroke(lineWidth: 1)
								.foregroundColor(.gray)
						)
						.frame(width: geometry.size.width, height: 80.0)
						.foregroundColor(tabColor)
				}
				HStack {
					ZStack {
						Rectangle()
							.foregroundColor(.white)
						HStack{
							Spacer()
							VStack(alignment: .leading) {
								HStack {
									Text("\(topicTitle)")
										.font(.headline)
									Spacer()
								}
								HStack {
									Text("\(numberOfMeditations) Meditations")
										.font(.subheadline)
										.fontWeight(.light)
									Spacer()
								}
							}
							.padding(.leading)
						}
					}
				}
				.padding(.leading)
			}
		}
		.frame(height: 80.0)
		.padding()

	}
}


struct TopicItem_Previews: PreviewProvider {
	static var previews: some View {
		TopicItemView(uuid: "1234",
					  topicTitle: "Test Title",
					  numberOfMeditations: 38,
					  tabColor: .red)
	}
}
