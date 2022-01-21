//
//  Music_appUITests.swift
//  Music appUITests
//
//  Created by stud on 25/10/2021.
//

import XCTest

import SwiftUI

class Music_appUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlaySong() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Songs"].tap()
        
        XCTAssertTrue(app.buttons["play_button"].exists)
        XCTAssertFalse(app.buttons["pause_button"].exists)
        
        app.buttons["Believer_button"].tap()
        sleep(3)
        
        XCTAssertFalse(app.buttons["play_button"].exists)
        XCTAssertTrue(app.buttons["pause_button"].exists)
        
        sleep(1)
        app.buttons["pause_button"].tap();
        sleep(2)
        
        XCTAssertTrue(app.buttons["play_button"].exists)
        XCTAssertFalse(app.buttons["pause_button"].exists)
    }
    
    func testAddSong() throws {
        let app = XCUIApplication()
        app.launch()
        let number = Int.random(in: 10...99)
        app.buttons["Songs"].tap()
        app.navigationBars.children(matching: .button).element(boundBy: 1).tap()
        app.buttons["file_picker"].tap()
        app.cells.firstMatch.tap()
        sleep(2)
        app.textFields["title_field"].tap()
        app.textFields["title_field"].typeText("test\(number)")
        app.textFields["author_field"].tap()
        app.textFields["author_field"].typeText("test\n")
        app.buttons["add_song_button"].tap()
        app.swipeUp()
        sleep(2)
        XCTAssertTrue(app.buttons["test\(number)_button"].exists)
        app.buttons["test\(number)_button"].press(forDuration: 3)
        sleep(5)
        app.buttons["Delete"].tap()
        sleep(3)
        XCTAssertFalse(app.buttons["test\(number)_button"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
            
        }
    }
}
