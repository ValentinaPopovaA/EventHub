//
//  UILabel+Ext.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit

extension UILabel {
    
    static func makeCustomLabel(
        text: String,
        fontSize: CGFloat,
        textColor: UIColor,
        numberOfLines: Int?,
        textAligment: NSTextAlignment?,
        wrapText: Bool = false) -> UILabel
    {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: fontSize)
        label.numberOfLines = numberOfLines ?? 0
        label.textColor = textColor
        label.textAlignment = textAligment ?? .left
        label.adjustsFontSizeToFitWidth = false
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = wrapText ? .byWordWrapping : .byTruncatingTail
        return label
    }

    static func makeCustomLabelBold(
        text: String,
        fontSize: CGFloat,
        textColor: UIColor,
        numberOfLines: Int?,
        textAligment: NSTextAlignment?,
        wrapText: Bool = false
    ) -> UILabel
    {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: fontSize)
        label.numberOfLines = numberOfLines ?? 0
        label.font = .boldSystemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = textAligment ?? .left
        label.adjustsFontSizeToFitWidth = false
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = wrapText ? .byWordWrapping : .byTruncatingTail
        return label
    }
}
