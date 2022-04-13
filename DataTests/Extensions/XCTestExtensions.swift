//
//  XCTestExtensions.swift
//  DataTests
//
//  Created by Rafael Scalzo on 13/04/22.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
