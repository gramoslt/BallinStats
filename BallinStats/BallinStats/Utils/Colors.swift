//
//  Colors.swift
//  BallinStats
//
//  Created by Gerardo Leal on 18/08/23.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var customRed: Color {
        Color("RedAccentColor")
    }
    static var customYellowStroke: Color {
        Color("StrokeColor")
    }
    static var customBackgroundColor: Color {
        Color("Dark-Blue-BackgroundColor")
    }
    static var redText: Color {
        Color("RedTextColor")
    }
}

extension Color {
    func getRGBComponents() -> (red: Double, green: Double, blue: Double)? {
        if let uiColor = UIColor(self).cgColor.components, uiColor.count >= 3 {
            let red = Double(uiColor[0])
            let green = Double(uiColor[1])
            let blue = Double(uiColor[2])
            return (red, green, blue)
        }
        return nil
    }

    func getGrayScaleValue() -> Double {
        let rgbComponents = self.getRGBComponents()
        let red = (rgbComponents?.red ?? 0)
        let green = (rgbComponents?.green ?? 0)
        let blue = (rgbComponents?.blue ?? 0)
        let grayScale = (red + green + blue) / 3
        return grayScale
    }
}
