//
//  SignUpViewControllerTests.swift
//  SignUpViewControllerTests
//
//  Created by Rafael Scalzo on 16/04/22.
//

import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() {
        let sut = SignUpViewController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
}

