//
//  DataLayerTests.swift
//  DataLayerTests
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import XCTest
@testable import DataLayer

class DataLayerTests: XCTestCase {
    let service = GitHubService()
    let geocoderSerivce = AppleGeocodingService()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContributors() {
        let expectation = XCTestExpectation(description: "fetch top contributors")
        service.getContributors(first: 50) { result in
            switch result {
            case .success(let users):
                XCTAssert(users.count == 50, "Must load 50 users")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }

    func testUsers() {
        let expectation = XCTestExpectation(description: "fetch top contributors")
        service.getUser(name: "alexey-kubas-appus") { result in
            switch result {
            case .success(let user):
                print(user)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }

    func testGeoCoder() {
        let expectation = XCTestExpectation(description: "coding coordinates")
        let address = "1 Infinite Loop"

        geocoderSerivce.geoCodeAddress(address) { result in
            switch result {
            case .success(let coordinates):
                print("lng:\(coordinates.long) lat: \(coordinates.lat)")
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 20)
    }
}
