//
//  ListRepositoriesWorkerTests.swift
//  ItauChallenge
//
//  Created by Vinicius Custodio on 24/07/20.
//  Copyright (c) 2020 Vinicius Custodio. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import ItauChallenge
import XCTest

class ListRepositoriesWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ListRepositoriesWorker!
    var mockGithubService: MockGithubService!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupListRepositoriesWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupListRepositoriesWorker() {
        mockGithubService = MockGithubService()
        sut = ListRepositoriesWorker(githubAPI: mockGithubService)
    }

    // MARK: Tests
    func testSuccessFindGithub() {
        // Given
        let expectation = self.expectation(description: "Repositories")
        mockGithubService.mockType = .searchRepos
        var didSucceed = false

        // When
        sut.findGithubRepositories(0) { (item) in
            switch item {
            case .success(_):
                didSucceed = true
                expectation.fulfill()
            case .failure(_):
                break
            }
        }

        // Then

        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertTrue(didSucceed)

    }
}


