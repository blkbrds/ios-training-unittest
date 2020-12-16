//
//  TestCase1.swift
//  DemoUnitTestTests
//
//  Created by Trung Le D. on 12/2/20.
//  Copyright © 2020 thuynguyen. All rights reserved.
//

import XCTest

class TestCase1: XCTestCase {

    override func setUpWithError() throws {
        func testSomething() {
            XCTAssert(1 + 1 == 2)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
       
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
