//
//  Color÷Extension.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 3.03.2025.
//


import SwiftUI

extension Color {
    var toUIColor: UIColor {
        UIColor(self)
    }
    
    init(r: CGFloat, g: CGFloat, b: CGFloat, opacity: Double = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, opacity: opacity)
    }

    static func dynamic(_ light: Color, _ dark: Color) -> Color {
        Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? dark.toUIColor : light.toUIColor
        })
    }
}
