//
//  BerlinClockService.swift
//  Berlin Clock
//
//  Created by George Muntean on 06/01/2021.
//

import Foundation

/**
 BerlinClockService will help processing a given time from Swift **Date** format to a Berlin time
*/

class BerlinClockService {
    
    // Each item from the time format represents the number of illuminated lamps from it's group
    // In the UI, the illuminated lamps will be displayed first
    struct TimeFormat {
        typealias NumberOfIlluminatedLamps = Int
        
        var seconds: NumberOfIlluminatedLamps = 0
        var fiveHour: NumberOfIlluminatedLamps = 0
        var oneHour: NumberOfIlluminatedLamps = 0
        var fiveMinute: NumberOfIlluminatedLamps = 0
        var oneMinute: NumberOfIlluminatedLamps = 0
    }
    
    func convert(time: Date) -> TimeFormat {
        var timeFormat = TimeFormat()
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: time)
        let hours = calendar.component(.hour, from: time)
        
        // When the number of seconds is odd, the lamp should be turned on
        timeFormat.seconds = 1 - (seconds % 2)
        
        timeFormat.fiveHour = hours / 5
        
        return timeFormat
    }
}
