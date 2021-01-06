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
    var normalTime = Dynamic(String())
    var timer: Timer?
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }
    
    func startShowingTime() {
        show(time: Date())
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                     repeats: true, block: { [weak self] _ in
                                        self?.show(time: Date())
                                     })
    }
    
    func stopShowingTime() {
        timer?.invalidate()
        timer = nil
    }
    
    func show(time: Date) {
        berlinTime.value = berlinClockService.convert(time: time)
        normalTime.value = dateFormatter.string(from: time)
    }
}
