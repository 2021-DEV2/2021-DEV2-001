//
//  BerlinClockViewModel.swift
//  Berlin Clock
//
//  Created by George Muntean on 06/01/2021.
//

import Foundation

class BerlinClockViewModel {
    
    let berlinClockService = BerlinClockService()
    var berlinTime = Dynamic(BerlinClockService.TimeFormat())
    
    func show(time: Date) {
        berlinTime.value = berlinClockService.convert(time: time)
    }
}
