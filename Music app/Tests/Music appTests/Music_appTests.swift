import XCTest
@testable import Music_app

final class Music_appTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Music_app().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
