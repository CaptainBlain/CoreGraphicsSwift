//
//  Circle.swift
//  CoreGraphicsSwift
//
//  Created by Blain Ellis on 26/02/2021.
//

import UIKit

@IBDesignable
class RecordCircle: UIView {
    
    @IBInspectable var outerColor: UIColor = #colorLiteral(red: 0.3450980392, green: 0.2509803922, blue: 0.7333333333, alpha: 1)
    @IBInspectable var innerColor: UIColor = #colorLiteral(red: 0.3450980392, green: 0.2509803922, blue: 0.7333333333, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        
        let outside = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: (bounds.height/2) - 3, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
        outside.lineWidth = 3
        outerColor.setStroke()
        outside.stroke()
        
        let inside = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: 1, startAngle: CGFloat(0), endAngle: CGFloat.pi * 2, clockwise: true)
        innerColor.setFill()
        inside.fill()
    }
}
