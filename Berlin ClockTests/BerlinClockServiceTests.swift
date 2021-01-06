//
//  Berlin_ClockTests.swift
//  Berlin ClockTests
//
//  Created by George Muntean on 06/01/2021.
//
import UIKit
import XCTest
@testable import Berlin_Clock

class BerlinClockServiceTests: XCTestCase {

    var berlinClockService: BerlinClockService!
    
    override func setUpWithError() throws {
        berlinClockService = BerlinClockService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSecondsLamp() {
        var time = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        var berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.secondsLamp, 1, "Seconds lamp should be illuminated for even seconds")
        
        time = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())
        var berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.secondsLamp, 0, "Seconds lamp should be off for odd seconds")
    }
}
