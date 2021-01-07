//
//  TopicsViewModel.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import Foundation
import os


struct TopicItemViewModel: Identifiable {
	var id: String
	let title: String?
	let featured: Bool
	let color: TopicColor
	let numberOfMeditations: Int
}


class TopicsViewModel: ObservableObject {
	
	// MARK: - Properties
	
	private static let subsystem = Bundle.main.bundleIdentifier!
	private static let category = "TopicsViewModel"
	private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: category)


	var allTopics: Topics? {
		didSet {
			guard let theTopics = allTopics else { return }
			print(theTopics)
		}
	}

	var topics: [Topic]?

	@Published var topicItemViewModels: [TopicItemViewModel]


	init() {
		guard let topicsDataPath = Bundle.main.path(forResource: "topics", ofType: "json") else {
			fatalError("No topics Data Found")
		}
		guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: topicsDataPath)) else {
			fatalError("Could not open.")
		}

		let allTopics = try! JSONDecoder().decode(Topics.self, from: jsonData)

		self.allTopics = allTopics

		self.topics = allTopics.topics.compactMap({ (topic) -> Topic? in
			topic
		})

		self.topicItemViewModels = allTopics.topics.compactMap({ (topic) -> TopicItemViewModel? in
			guard let theColor = topic.color else { return nil }
			return TopicItemViewModel(id: topic.uuid,
									  title: topic.title,
									  featured: topic.featured,
									  color: theColor,
									  numberOfMeditations: topic.meditations.count)
		}).filter({ (topicItemViewModel) -> Bool in
			return topicItemViewModel.featured
		}).sorted(by: { (lhs, rhs) -> Bool in
			guard
				let lhsTitle = lhs.title,
				let rhsTitle = rhs.title else {
				return false
			}
			return lhsTitle < rhsTitle
		})

	}

}
