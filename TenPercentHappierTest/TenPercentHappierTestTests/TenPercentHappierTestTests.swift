//
//  TenPercentHappierTestTests.swift
//  TenPercentHappierTestTests
//
//  Created by Stanley Rosenbaum on 1/6/21.
//

import XCTest
@testable import TenPercentHappierTest

class TenPercentHappierTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	
	func testTopicsModel() {

		guard let topicsDataPath = Bundle.main.path(forResource: "topics", ofType: "json") else {
			fatalError("No topics Data Found")
		}
		guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: topicsDataPath)) else {
			fatalError("Could not open.")
		}

		let allTopics = try! JSONDecoder().decode(Topics.self, from: jsonData)

		XCTAssertTrue(type(of: allTopics) == Topics.self, "type(of: allTopics) != Topics")

	}


	func testTopicsViewModel() {

		let topicsViewModel = TopicsViewModel()

		print(topicsViewModel.topics as Any)
		print(topicsViewModel.topics?.count as Any)

		XCTAssertTrue(topicsViewModel.topics?.count == 47, "topicsViewModel.topics != 47")
	}


	func testTopicItemViewModel() {

		let topicsViewModel = TopicsViewModel()

		print(topicsViewModel.topicItemViewModels as Any)
		print(topicsViewModel.topicItemViewModels.count as Any)

//		XCTAssertTrue(topicsViewModel.topics?.count == 47, "topicsViewModel.topics != 47")
	}

}
