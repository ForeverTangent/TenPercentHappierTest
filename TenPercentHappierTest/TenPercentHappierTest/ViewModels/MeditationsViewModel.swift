//
//  MeditationViewModel.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/7/21.
//

import Foundation
import os

struct MeditationItemViewModel: Identifiable {
	let id: String?
	let imageURL: String?
	let teacherName: String?
	let title: String?
	let playCount: Int?
}

class MeditationsViewModel: ObservableObject {

	// MARK: - Properties

	private static let subsystem = Bundle.main.bundleIdentifier!
	private static let category = "TopicsViewModel"
	private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: category)

	var allMeditations: Meditations?

	var medications: [Meditation]? {
		didSet {
			guard let theMedications = medications else { return }
			print(theMedications)
		}
	}

	@Published var meditationItemViewModels: [MeditationItemViewModel]?

	init() {
		let defaultSession = URLSession(configuration: .default)
		var dataTask: URLSessionDataTask?

		dataTask?.cancel()

		// 2
		if let urlComponents = URLComponents(string: "https://tenpercent-interview-project.s3.amazonaws.com/meditations.json") {
			guard let url = urlComponents.url else {
				return
			}

			dataTask = defaultSession.meditationsTask(with: url) { meditations, response, error in
				defer {
					dataTask = nil
				}

				if let theError = error {
					self.logger.error("\(theError.localizedDescription)")
				} else if
					let theMeditations = meditations,
					let response = response as? HTTPURLResponse,
					response.statusCode == 200 {

					let allMeditations = theMeditations

					self.allMeditations = allMeditations

					self.medications = allMeditations.meditations?.compactMap({ (medititation) -> Meditation? in
						medititation
					})

					let theMeditationItemViewModels = allMeditations.meditations?.compactMap({ (meditation) -> MeditationItemViewModel? in
						return MeditationItemViewModel(id: meditation.uuid,
													   imageURL: meditation.imageURL,
													   teacherName: meditation.teacherName,
													   title: meditation.title,
													   playCount: meditation.playCount)
					}) ?? [MeditationItemViewModel]()

					DispatchQueue.main.async {
						self.meditationItemViewModels = theMeditationItemViewModels.sorted(by: { (lhs, rhs) -> Bool in
							guard
								let theLHSPlayCount = lhs.playCount,
								let theRHSPlayCount = rhs.playCount else { return false }
							return theLHSPlayCount > theRHSPlayCount
						})
					}

				}
			}

			dataTask?.resume()


		// Old Code for loading locally for testing.
//		guard let topicsDataPath = Bundle.main.path(forResource: "meditations", ofType: "json") else {
//			fatalError("No meditations Data Found")
//		}
//		guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: topicsDataPath)) else {
//			fatalError("Could not open.")
//		}
//
//		let allMeditations = try! JSONDecoder().decode(Meditations.self, from: jsonData)
//
//
//		self.medications = allMeditations.meditations?.compactMap({ (medititation) -> Meditation? in
//			medititation
//		})
//
//		let theMeditationItemViewModels = allMeditations.meditations?.compactMap({ (meditation) -> MeditationItemViewModel? in
//			return MeditationItemViewModel(id: meditation.uuid,
//										   imageURL: meditation.imageURL,
//										   teacherName: meditation.teacherName,
//										   title: meditation.title,
//										   playCount: meditation.playCount)
//		}) ?? [MeditationItemViewModel]()
//
//		self.meditationItemViewModels = theMeditationItemViewModels.sorted(by: { (lhs, rhs) -> Bool in
//			guard
//				let theLHSPlayCount = lhs.playCount,
//				let theRHSPlayCount = rhs.playCount else { return false }
//			return theLHSPlayCount > theRHSPlayCount
//		})

		}

	}

}
