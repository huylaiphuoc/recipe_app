//
//  UILabelExtention.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import UIKit

extension UILabel {
    public var lineHeight: CGFloat? {
        get { nil }
        set {
            
            // Values.
            let lineHeight = newValue ?? font.lineHeight
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
            
            // Paragraph style.
            let mutableParagraphStyle = NSMutableParagraphStyle()
            mutableParagraphStyle.minimumLineHeight = lineHeight
            mutableParagraphStyle.maximumLineHeight = lineHeight
            mutableParagraphStyle.lineBreakMode = .byTruncatingTail
            
            // Set
            attributedText = NSAttributedString(
                string: text ?? "",
                attributes: [
                    .baselineOffset: baselineOffset,
                    .paragraphStyle: mutableParagraphStyle
                ]
            )
        }
    }
}
