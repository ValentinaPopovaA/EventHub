//
//  UIStackView.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacinng: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacinng
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
