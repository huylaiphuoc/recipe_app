//
//  StringExtension.swift
//  recipe-app
//
//  Created by Huy Lai on 26/03/2024.
//

import Foundation

extension String {
    var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
