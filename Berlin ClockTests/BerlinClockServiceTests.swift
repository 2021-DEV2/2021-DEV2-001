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
    
    struct Assertion {
        // Time format: HH:mm:ss
        let normalTime: String
        
        // Berlin time format: SecondsLamp:FiveHourLamps:OneHourLamps:FiveMinuteLamps:OneMinuteLamps
        // The character "?" will be used for lamps we don't want to check
        let berlinTime: String
        
        let assertionError: String
    }
    
    var berlinClockService: BerlinClockService!
    
    override func setUpWithError() throws {
        berlinClockService = BerlinClockService()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func test(assertions: [Assertion]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        assertions.forEach { assertion in
            guard let time = dateFormatter.date(from: assertion.normalTime) else {
                XCTFail("The time is not specified in the correct format")
                preconditionFailure()
            }
            let calculatedBerlinTime = berlinClockService.convert(time: time)
            let berlinTimeComponents = assertion.berlinTime.components(separatedBy: ":")
            
            // Character "?" will fail converting to Int, and will not be taken into consideration when testing
            if let seconds = Int(berlinTimeComponents[0]) {
                XCTAssertEqual(seconds, calculatedBerlinTime.seconds, assertion.assertionError)
            }
            
            if let fiveHour = Int(berlinTimeComponents[1]) {
                XCTAssertEqual(fiveHour, calculatedBerlinTime.fiveHour, assertion.assertionError)
            }
            
            if let oneHour = Int(berlinTimeComponents[2]) {
                XCTAssertEqual(oneHour, calculatedBerlinTime.oneHour, assertion.assertionError)
            }
            
            if let fiveMinute = Int(berlinTimeComponents[3]) {
                XCTAssertEqual(fiveMinute, calculatedBerlinTime.fiveMinute, assertion.assertionError)
            }
            
            if let oneMinute = Int(berlinTimeComponents[4]) {
                XCTAssertEqual(oneMinute, calculatedBerlinTime.oneMinute, assertion.assertionError)
            }
        }
    }
    
    func testSecondsLamp() {
        let assertions = [
            Assertion(normalTime: "00:00:00",
                      berlinTime: "1:?:?:?:?",
                      assertionError: "Seconds lamp should be illuminated for even seconds"),
            Assertion(normalTime: "23:59:59",
                      berlinTime: "0:?:?:?:?",
                      assertionError: "Seconds lamp should be off for odd seconds")
        ]
        test(assertions: assertions)
    }
    
    func testFiveHoursLamps() {
        let assertions = [
            Assertion(normalTime: "00:00:00",
                      berlinTime: "?:0:?:?:?",
                      assertionError: "Five hour lamps should be all off at midnight"),
            Assertion(normalTime: "23:59:59",
                      berlinTime: "?:4:?:?:?",
                      assertionError: "Five hour lamps should be all on one minute before midnight"),
            Assertion(normalTime: "02:04:00",
                      berlinTime: "?:0:?:?:?",
                      assertionError: "Five hour lamps should be all off before five'o'clock"),
            Assertion(normalTime: "16:35:00",
                      berlinTime: "?:3:?:?:?",
                      assertionError: "Five hour lamps should light 3 items after 15:00")
        ]
        test(assertions: assertions)
    }
    
    func testOneHourLamps() {
        let assertions = [
            Assertion(normalTime: "00:00:00",
                      berlinTime: "?:?:0:?:?",
                      assertionError: "One hour lamps should be all off at midnight"),
            Assertion(normalTime: "23:59:59",
                      berlinTime: "?:?:3:?:?",
                      assertionError: "One hour lamps should light 3 items on one minute before midnight"),
            Assertion(normalTime: "02:04:00",
                      berlinTime: "?:?:2:?:?",
                      assertionError: "One hour lamps should light 2 items right after two'o'clock"),
            Assertion(normalTime: "08:23:00",
                      berlinTime: "?:?:3:?:?",
                      assertionError: "One hour lamps should light 3 items right after eight'o'clock"),
            Assertion(normalTime: "14:35:00",
                      berlinTime: "?:?:4:?:?",
                      assertionError: "One hour lamps should light 4 items right after 2 PM")
        ]
        test(assertions: assertions)
    }
    
    func testFiveMinutesLamps() {
        let assertions = [
            Assertion(normalTime: "00:00:00",
                      berlinTime: "?:?:?:0:?:?",
                      assertionError: "Five minutes lamps should be all off at midnight"),
            Assertion(normalTime: "23:59:59",
                      berlinTime: "?:?:?:11:?:?",
                      assertionError: "Five minutes lamps should be all on one minute before midnight"),
            Assertion(normalTime: "12:04:00",
                      berlinTime: "?:?:?:0:?:?",
                      assertionError: "Five minutes lamps should be all off when minutes are lower than five"),
            Assertion(normalTime: "12:23:00",
                      berlinTime: "?:?:?:4:?:?",
                      assertionError: "Five minutes lamps should light 4 items between 20 and 25 minutes "),
        ]
        test(assertions: assertions)
    }
}
