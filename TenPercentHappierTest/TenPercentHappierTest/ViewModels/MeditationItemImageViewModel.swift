//
//  MeditationsItemViewModel.swift
//  TenPercentHappierTest
//
//  Created by Stanley Rosenbaum on 1/7/21.
//

import Foundation
import UIKit
import os


class MeditationItemImageViewModel: ObservableObject {
	var image: UIImage = UIImage(named: "TEMP")!
	
	private var imageURLString: String?

	private static let subsystem = Bundle.main.bundleIdentifier!
	private static let category = "ImageViewModel"
	private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: category)

	init(urlString: String?) {

		guard let theURLString = urlString else {
			return
		}

		self.imageURLString = theURLString

		guard
			let theImageURLString = imageURLString,
			let theURL = URL(string: theImageURLString)
		else {
			return
		}

		let task = URLSession.shared.dataTask(with: theURL) { (data: Data?, response: URLResponse?, error: Error?) in
			guard
				error == nil,
				let theData = data else {
				self.logger.error("\(error! as NSObject)")
				return
			}

			DispatchQueue.main.async {
				guard let loadedImage = UIImage(data: theData) else { return }
				self.image = loadedImage
			}
		}


		task.resume()
	}

}
