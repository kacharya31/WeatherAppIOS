//
//  Extensions.swift
//  WeatherApp
//
//  Created by Krithik Acharya on 9/10/23.
//

import Foundation
import SwiftUI

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension View {
    func customCornerRadius(_ radiusValue: CGFloat, for corners: UIRectCorner) -> some View {
        clipShape(CustomRoundedCornerShape(radius: radiusValue, cornerTypes: corners))
    }
}

struct CustomRoundedCornerShape: Shape {
    var radius: CGFloat
    var cornerTypes: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let bezierPath = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: cornerTypes,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(bezierPath.cgPath)
    }
}

