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
    @IBInspectable var middleColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    @IBInspectable var innerColor: UIColor = #colorLiteral(red: 0.3450980392, green: 0.2509803922, blue: 0.7333333333, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect.insetBy(dx: 2, dy: 2))
        middleColor.setFill()
        path.fill()
        
        outerColor.setStroke()
        path.lineWidth = 3
        path.stroke()
        
        let inside = UIBezierPath(ovalIn: rect.insetBy(dx: 20, dy: 20))
        innerColor.setFill()
        inside.fill()
    }
}
