//
//  TopContributorsTests.swift
//  TopContributorsTests
//
//  Created by Andrew Mysyk on 4/24/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import XCTest
@testable import TopContributors

class TopContributorsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func validateModule<View: ViperView, Presenter: ViperPresenter, Interactor: ViperInteractor, Router: ViperRouter>(_ module: Module<View, Presenter, Interactor, Router>) {
        //check module refs
        XCTAssertNotNil(module.interactor)
        XCTAssertNotNil(module.presenter)
        XCTAssertNotNil(module.router)
        XCTAssertNotNil(module.view)
        //check view refs
        XCTAssertNotNil(module.view.presenter)
        XCTAssertNotNil(module.view.viperComponents)
        //check interactor refs
        XCTAssertNotNil(module.interactor.presenter)
        //check presenter refs
        XCTAssertNotNil(module.presenter.view)
        XCTAssertNotNil(module.presenter.interactor)
        XCTAssertNotNil(module.presenter.router)
        //check presenter refs
        XCTAssertNotNil(module.router.presenter)
        XCTAssertNotNil(module.router.viewController)
    }

    func testContributorsListModule() {
        validateModule(Modules.contributorsList())
    }

    func testMapModule() {
        let address = "1 Infinite Loop"
        let map = Modules.map(location: (0, 0), name: address)
        validateModule(map)
    }

}
