//
//  UIView+Illuminated.swift
//  Berlin Clock
//
//  Created by George Muntean on 06/01/2021.
//

import UIKit

extension UIView {
    var isIlluminated: Bool {
        set {
            if newValue == true {
                layer.borderColor = UIColor.lightGray.cgColor
                layer.borderWidth = 3
                backgroundColor =  backgroundColor?.withAlphaComponent(1)
            } else {
                layer.borderWidth = 3
                layer.borderColor = UIColor.lightGray.cgColor
                backgroundColor =  backgroundColor?.withAlphaComponent(0)
            }
        }
        get {
            return false
        }
    }
}
