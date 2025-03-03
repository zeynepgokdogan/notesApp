//
//  AppColors.swift
//  notesApp
//
//  Created by Zeynep Gökdoğan on 3.03.2025.
//

import SwiftUI

extension Color {
    struct AppPrimary {
        static let vibrantPurple: Color = .dynamic(vibrantPurpleLight, vibrantPurpleDark)
        private static let vibrantPurpleLight: Color = .init(r: 138, g: 43, b: 226)
        private static let vibrantPurpleDark: Color = .init(r: 120, g: 30, b: 200)
    }
}
