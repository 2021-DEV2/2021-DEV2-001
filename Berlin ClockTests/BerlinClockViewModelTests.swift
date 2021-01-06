//
//  BerlinClockViewModelTests.swift
//  Berlin ClockTests
//
//  Created by George Muntean on 06/01/2021.
//

import XCTest
@testable import Berlin_Clock

class BerlinClockViewModelTests: XCTestCase {
    
    var sut: BerlinClockViewModel!
    
    override func setUpWithError() throws {
        sut = BerlinClockViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowTime() {
        // Given
        let time = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        
        //give some time for the rendering
        let showTimeExpectation = expectation(description: "showTimeExpectation")
    
        // Then
        // Set-up binding
        sut.berlinTime.bind { berlinTime in
            XCTAssertEqual(berlinTime.seconds, 1, "Seconds lamp should light at midnight")
            showTimeExpectation.fulfill()
        }
        
        // When
        sut.show(time: time)
    
        waitForExpectations(timeout: 5, handler: nil)
    }
}
