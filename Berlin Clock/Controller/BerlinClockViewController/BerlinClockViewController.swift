//
//  BerlinClockViewController.swift
//  Berlin Clock
//
//  Created by George Muntean on 06/01/2021.
//

import UIKit

class BerlinClockViewController: UIViewController {
    
    @IBOutlet var secondsLamp: UIView!
    @IBOutlet var fiveHourLamps: [UIView]!
    @IBOutlet var oneHourLamps: [UIView]!
    @IBOutlet var fiveMinuteLamps: [UIView]!
    @IBOutlet var oneMinuteLamps: [UIView]!
    @IBOutlet var normalClockLabel: UILabel!
    
    private var viewModel = BerlinClockViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startShowingTime()
    }
    
    private func setupBinding() {
        viewModel.berlinTime.bind { [weak self] berlinTime in
            self?.secondsLamp.isIlluminated = (berlinTime.seconds == 1)
            self?.fiveHourLamps.enumerated().forEach { index, lamp in
                lamp.isIlluminated = berlinTime.fiveHour > index
            }
            self?.oneHourLamps.enumerated().forEach { index, lamp in
                lamp.isIlluminated = berlinTime.oneHour > index
            }
            self?.fiveMinuteLamps.enumerated().forEach { index, lamp in
                lamp.isIlluminated = berlinTime.fiveMinute > index
            }
            self?.oneMinuteLamps.enumerated().forEach { index, lamp in
                lamp.isIlluminated = berlinTime.oneMinute > index
            }
        }
        
        viewModel.normalTime.bind { [weak self] normalTime in
            self?.normalClockLabel.text = normalTime
        }
    }
}

