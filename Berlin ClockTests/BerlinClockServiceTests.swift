//
//  BerlinClockServiceTests.swift
//  BerlinClockServiceTests
//
//  Created by George Muntean on 06/01/2021.
//

import Foundation
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
        var time = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        var berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.seconds, 1, "Seconds lamp should be illuminated for even seconds")
        
        time = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!
        berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.seconds, 0, "Seconds lamp should be off for odd seconds")
    }
    
    func testFiveHoursLamps() {
        var time = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
        var berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.fiveHour, 0, "Five hour lamps should be all off at midnight")
        
        time = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date())!
        berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.fiveHour, 4, "Five hour lamps should be all on one minute before midnight")
        
        time = Calendar.current.date(bySettingHour: 2, minute: 4, second: 0, of: Date())!
        berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.fiveHour, 0, "Five hour lamps should be all off before five'o'clock")
        
        time = Calendar.current.date(bySettingHour: 16, minute: 35, second: 0, of: Date())!
        berlinTime = berlinClockService.convert(time: time)
        XCTAssertEqual(berlinTime.fiveHour, 3, "Five hour lamps should light 3 items after 15:00")
    }
}
