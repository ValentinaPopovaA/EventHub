//
//  HTMLToString.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import UIKit

extension String {
    func htmlToAttributedString() -> NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            print("Error converting HTML to attributed string: \(error)")
            return nil
        }
    }

    func htmlToString() -> String {
        return htmlToAttributedString()?.string ?? self
    }
}
