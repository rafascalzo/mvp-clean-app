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
    
    func test_sut_implements_loading_view_protocol() {
        let sut = SignUpViewController()
        XCTAssertNotNil(sut as LoadingView)
    }
    
    func test_sut_implements_alert_view_protocol() {
        let sut = SignUpViewController()
        XCTAssertNotNil(sut as AlertView)
    }
}

