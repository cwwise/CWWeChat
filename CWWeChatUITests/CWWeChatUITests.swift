//
//  CWWeChatUITests.swift
//  CWWeChatUITests
//
//  Created by chenwei on 16/6/24.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import XCTest

class CWWeChatUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        let app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        snapshot("Message")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTabbarContact() {
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["通讯录"].tap()
        
        snapshot("Contact")
    }
    
    func testTabbarDiscover() {
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["发现"].tap()
        
        snapshot("Discover")
    }
    
    func testTabbarMine() {
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["我"].tap()
        snapshot("Mine")
    }
    
    func snapshot(_ string: String) {
        
    }
    
}
