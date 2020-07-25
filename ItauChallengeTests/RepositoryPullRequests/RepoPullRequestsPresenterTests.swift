//
//  RepoPullRequestsPresenterTests.swift
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

class RepoPullRequestsPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: RepoPullRequestsPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupRepoPullRequestsPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupRepoPullRequestsPresenter() {
        sut = RepoPullRequestsPresenter()
    }

    // MARK: Tests
    func testFindPullRequests() {
        // Given
        let mock = MockRepoPullRequestsDisplayLogic()
        sut.viewController = mock
        let response = RepoPullRequests.LoadPullRequests.Response(pullRequests: [])

        // When
        sut.didFindPullRequests(response)

        // Then
        XCTAssertTrue(mock.displayedPullRequests)
    }

    func testFailFindPullRequests() {
        // Given
        let mock = MockRepoPullRequestsDisplayLogic()
        sut.viewController = mock

        // When
        sut.didFailFindPullRequests(GithubAPIError.decodingError)

        // Then
        XCTAssertTrue(mock.displayedError)
    }
}

class MockRepoPullRequestsDisplayLogic: RepoPullRequestsDisplayLogic {
    var displayedPullRequests: Bool = false
    var displayedError: Bool = false

    func showPullRequests(_ viewModel: RepoPullRequests.LoadPullRequests.ViewModel) {
        displayedPullRequests = true
    }

    func showError(_ error: Error) {
        displayedError = true
    }


}
