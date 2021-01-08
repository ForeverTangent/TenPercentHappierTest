//
//  TopicsViewModel.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import Foundation
import os

/**
Our Filters Topics View Model
*/
struct TopicItemViewModel: Identifiable {
	var id: String
	var parentID: String?
	let title: String?
	let featured: Bool
	let color: TopicColor
	let numberOfMeditations: Int
	let meditations: [String]
}


/**
Main Topics View Model
*/
class TopicsViewModel: ObservableObject {
	
	// MARK: - Properties
	
	private static let subsystem = Bundle.main.bundleIdentifier!
	private static let category = "TopicsViewModel"
	private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: category)

	var allTopics: Topics?
//	// Mainly for Testing
//	{
//		didSet {
//			guard let theTopics = allTopics else { return }
//			print(theTopics)
//		}
//	}

	var topics: [Topic]?

	@Published var topicItemViewModels: [TopicItemViewModel]?

	init() {

		let defaultSession = URLSession(configuration: .default)
		var dataTask: URLSessionDataTask?

		dataTask?.cancel()

		// 2
		if let urlComponents = URLComponents(string: "https://tenpercent-interview-project.s3.amazonaws.com/topics.json") {
			guard let url = urlComponents.url else {
				return
			}

			dataTask = defaultSession.topicsTask(with: url) { topics, response, error in
				defer {
					dataTask = nil
				}

				if let theError = error {
					self.logger.error("\(theError.localizedDescription)")
				} else if
					let theTopics = topics,
					let response = response as? HTTPURLResponse,
					response.statusCode == 200 {

					let allTopics = theTopics

					self.allTopics = allTopics

					self.topics = allTopics.topics.compactMap({ (topic) -> Topic? in
						topic
					})

					DispatchQueue.main.async {
						self.topicItemViewModels = allTopics.topics.compactMap({ (topic) -> TopicItemViewModel? in
							guard
								let theColor = topic.color,
								let theParentUUID = topic.parentUUID else { return nil }
							return TopicItemViewModel(id: topic.uuid,
													  parentID: theParentUUID,
													  title: topic.title,
													  featured: topic.featured,
													  color: theColor,
													  numberOfMeditations: topic.meditations.count,
													  meditations: topic.meditations)
						}).filter({ (topicItemViewModel) -> Bool in
							return topicItemViewModel.featured || (topicItemViewModel.parentID != nil)
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
			}

			dataTask?.resume()

		}

	}

}
