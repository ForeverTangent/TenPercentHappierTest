//
//  ContentView.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import SwiftUI

//“ScrollView {
//	ForEach(flightData) { flight in
//		VStack {
//			Text("\(flight.airline) \(flight.number)")
//			Text("\(flight.flightStatus) at \(flight.currentTimeString)")
//			Text("At gate \(flight.gate)")
//		}
//	}
//}”
//
//Excerpt From: By Audrey Tam. “SwiftUI by Tutorials.” Apple Books.

struct TopicsView: View {
	@ObservedObject var topicsViewModel = TopicsViewModel()

	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(topicsViewModel.topicItemViewModels) { (topicItemViewModel) in
					TopicItemView(uuid: topicItemViewModel.id,
								  topicTitle: topicItemViewModel.title ?? "",
								  numberOfMeditations: topicItemViewModel.numberOfMeditations,
								  tabColor: TopicColor.getUIColor(value: topicItemViewModel.color))
				}
			}
			.navigationTitle("Topics")
		}

	}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		TopicsView()
    }
}
