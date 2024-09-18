//
//  Extensions.swift
//  day6
//
//  Created by Doeun Kwon on 2024-09-17.
//

import UIKit

extension UIFont {
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
