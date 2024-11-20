//
//  Pie.swift
//  Memorize
//
//  Created by Hannes Richter on 20.11.24.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle = Angle.zero
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = rect.midPoint
        let radius = min(rect.width / 2, rect.height / 2)
        let startPoint = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var path = Path()
        path.move(to: center)
        path.addLine(to: startPoint)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        path.addLine(to: center)
        return path
    }
}
