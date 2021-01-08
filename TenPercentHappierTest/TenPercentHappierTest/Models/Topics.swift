//
//  Topics.swift
//  TenPercentHappierTest
//

// Using Good Old Quikctype
// 
//  Created by Stanley Rosenbaum on 1/7/21.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topics = try? newJSONDecoder().decode(Topics.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.topicsTask(with: url) { topics, response, error in
//     if let topics = topics {
//       ...
//     }
//   }
//   task.resume()

import Foundation
import SwiftUI

// MARK: - Topics
struct Topics: Codable {
	let topics: [Topic]
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.topicTask(with: url) { topic, response, error in
//     if let topic = topic {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Topic
struct Topic: Codable {
	let color: TopicColor?
	let topicDescription, descriptionShort: String?
	let featured: Bool
	let imageURL: String?
	let meditations: [String]
	let parentUUID: String?
	let position: Int
	let thumbnailURL: String?
	let title, uuid: String

	enum CodingKeys: String, CodingKey {
		case color
		case topicDescription = "description"
		case descriptionShort = "description_short"
		case featured
		case imageURL = "image_url"
		case meditations
		case parentUUID = "parent_uuid"
		case position
		case thumbnailURL = "thumbnail_url"
		case title, uuid
	}
}

enum TopicColor: String, Codable {
	case tCyan = "#B1E2E2"
	case tGreen = "#CCE5CE"
	case tPaleBlue = "#D8EBF9"
	case tPurple = "#DFD7E9"
	case tGray = "#DFE5E7"

	static func getUIColor(value: TopicColor) -> Color {
		switch value {
			case .tCyan:
				return Color.blue
			case .tGreen:
				return Color.green
			case .tPaleBlue:
				return Color.blue
			case .tPurple:
				return Color.purple
			case .tGray:
				return Color.gray
		}
	}
}

extension String {
	subscript(_ i: Int) -> String {
		let idx1 = index(startIndex, offsetBy: i)
		let idx2 = index(idx1, offsetBy: 1)
		return String(self[idx1..<idx2])
	}

	subscript (r: Range<Int>) -> String {
		let start = index(startIndex, offsetBy: r.lowerBound)
		let end = index(startIndex, offsetBy: r.upperBound)
		return String(self[start ..< end])
	}

	subscript (r: CountableClosedRange<Int>) -> String {
		let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
		let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
		return String(self[startIndex...endIndex])
	}
}


// MARK: - URLSession response handlers

extension URLSession {
	fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
				completionHandler(nil, response, error)
				return
			}
			completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
		}
	}

	func topicsTask(with url: URL, completionHandler: @escaping (Topics?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.codableTask(with: url, completionHandler: completionHandler)
	}
}
