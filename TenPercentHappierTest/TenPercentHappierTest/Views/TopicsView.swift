//
//  ContentView.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import SwiftUI

struct TopicsView: View {
	@ObservedObject var topicsViewModel = TopicsViewModel()

	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(topicsViewModel.topicItemViewModels ?? [TopicItemViewModel]()) { (topicItemViewModel) in
					NavigationLink(destination: MeditationsView(currentMeditations: topicItemViewModel.meditations)) {
						TopicItemView(uuid: topicItemViewModel.id,
									  topicTitle: topicItemViewModel.title ?? "",
									  numberOfMeditations: topicItemViewModel.numberOfMeditations,
									  tabColor: TopicColor.getUIColor(value: topicItemViewModel.color))
					}

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
