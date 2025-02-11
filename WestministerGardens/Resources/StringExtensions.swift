//
//  StringExtensions.swift
//  WestministerGardens
//
//  Created by Maggie Otto on 21/01/2025.
//

//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
