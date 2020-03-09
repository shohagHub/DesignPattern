//
//  DesignPatternTests.swift
//  DesignPatternTests
//
//  Created by Saleh Enam Shohag on 31/1/20.
//  Copyright © 2020 Saleh Enam Shohag. All rights reserved.
//

import XCTest
@testable import DesignPattern

class DesignPatternTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSingleton() {
        if let maxDownload = AppSettings.shared.int(forKey: "maxConcurrentDownload") {
            print(maxDownload)
        }
        if let theme = AppSettings.shared.string(forKey: "Theme") {
            print(theme)
        }
    }
    
    //This will crash as
    //singletone dic is read and write from multiple thread6yfh
    func testConcrrentUsageWillCrash() {
        let conCurrentqueue = DispatchQueue(label: "ConcurrentTest", attributes: .concurrent)
        let expect = expectation(description: "Using Appsetting singleton from multiple thread succeed")
        
        let callCount = 100
        for callIndex in 1...callCount {
            conCurrentqueue.async {
                AppSettings.shared.set(value: callIndex, forKey: String(callIndex))
            }
        }
        
        while AppSettings.shared.int(forKey: String(callCount)) != callCount {
            //nop
        }
        expect.fulfill()
        waitForExpectations(timeout: 5, handler: {(error) in
            XCTAssertNil(error, "Test Expectation failed")
        })
    }
    
    //takes time 0.064
    func testConcrrentUsageWithSerialQueue() {
        let conCurrentqueue = DispatchQueue(label: "ConcurrentTest", attributes: .concurrent)
        let expect = expectation(description: "Using Appsetting singleton from multiple thread succeed")
        
        let callCount = 1000
        for callIndex in 1...callCount {
            conCurrentqueue.async {
                AppSettingsWithSearialQuuue.shared.set(value: callIndex, forKey: String(callIndex))
            }
        }
        
        while AppSettingsWithSearialQuuue.shared.int(forKey: String(callCount)) != callCount {
            //nop
        }
        expect.fulfill()
        waitForExpectations(timeout: 5, handler: {(error) in
            XCTAssertNil(error, "Test Expectation failed")
        })
    }
    
    //Performance optimized
    //take time 0.027
    func testConcrrentUsageWithConcurrentQueue() {
        let conCurrentqueue = DispatchQueue(label: "ConcurrentTest", attributes: .concurrent)
        let expect = expectation(description: "Using Appsetting singleton from multiple thread succeed")
        
        let callCount = 1000
        for callIndex in 1...callCount {
            conCurrentqueue.async {
                AppSettingsPerformanceOptimise.shared.set(value: callIndex, forKey: String(callIndex))
            }
        }
        
        while AppSettingsPerformanceOptimise.shared.int(forKey: String(callCount)) != callCount {
            //nop
        }
        expect.fulfill()
        waitForExpectations(timeout: 5, handler: {(error) in
            XCTAssertNil(error, "Test Expectation failed")
        })
    }

}
