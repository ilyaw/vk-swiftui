//
//  Color + Extension.swift
//  VKClient
//
//  Created by Ilya on 14.09.2021.
//

import SwiftUI

extension Color {
    static let vkBlue = Color(#colorLiteral(red: 0.1529411765, green: 0.5294117647, blue: 0.9607843137, alpha: 1))
    static let subtext = getColorRGB(red: 161.0, green: 165.0, blue: 169.0)
    
    private static func getColorRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> Color {
        return Color(red: red / 255.0,
                       green: green / 255.0,
                       blue: blue / 255.0)
    }
}
