//
//  ColourPalette.swift
//  WestministerGardens
//
//  Created by Maggie Otto on 11/02/2025.
//


//
//  ColourPalette.swift
//  WestministerGardens
//
//  Created by Yukie on 26/09/2024.
//

import SwiftUI

struct ColourPalette {
    static var backgroundColor: LinearGradient {
        let traitCollection = UITraitCollection.current // Access the current trait collection
        return traitCollection.userInterfaceStyle == .dark ? blackGradientBackground : whiteGradientBackground
    }
    static let contentBackgroundColor: Color = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.2, alpha: 1.0) : UIColor(white: 1.0, alpha: 1.0)
    })

    static let textColor: Color = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
    })

    static let headingColor: Color = Color.blue // Using a static color that works well in both modes

    static let blackGradientBackground: LinearGradient = {
        let gradient = Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(1.0)])
        return LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
    }()

    static let whiteGradientBackground: LinearGradient = {
        let gradient = Gradient(colors: [Color.white.opacity(0.8), Color.white])
        return LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
    }()
}
