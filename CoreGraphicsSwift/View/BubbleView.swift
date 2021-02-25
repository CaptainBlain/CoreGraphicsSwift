//
//  BubbleView.swift
//  CoreGraphicsSwift
//
//  Created by Blain Ellis on 25/02/2021.
//

import UIKit

@IBDesignable
class BubbleView: UIView {

    @IBInspectable var lineWidth: CGFloat = 4 { didSet { setNeedsDisplay() } }
    @IBInspectable var cornerRadius: CGFloat = 8 { didSet { setNeedsDisplay() } }
  
    @IBInspectable var strokeColor: UIColor = .red { didSet { setNeedsDisplay() } }
    @IBInspectable var fillColor: UIColor = .gray { didSet { setNeedsDisplay() } }
    
    @IBInspectable var peakWidth: CGFloat  = 10 { didSet { setNeedsDisplay() } }
    @IBInspectable var peakHeight: CGFloat = 10 { didSet { setNeedsDisplay() } }
    @IBInspectable var peakOffset: CGFloat = 30 { didSet { setNeedsDisplay() } }
    
    private var selectedPeakSide: PeakSide = .Left
    private enum PeakSide: Int {
        case Top
        case Left
        case Right
        case Bottom
    }
    
    
    
    
    override func draw(_ rectangle: CGRect) {
        
        //Add a bounding area so we can fit the peak in the view
        let rect = bounds.insetBy(dx: (peakHeight + lineWidth/2), dy: (peakHeight + lineWidth/2))
        //Peak height
        let h: CGFloat = peakHeight * sqrt(3.0) / 2
        
        //create the path
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        // Start of bubble (Top Left)
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
                          controlPoint: CGPoint(x: rect.minX, y: rect.minY))
        
        if selectedPeakSide == .Top {
            let x = rect.midX
            let y = rect.minY
            path.addLine(to: CGPoint(x: (x + peakOffset) - peakWidth, y: y))
            path.addLine(to: CGPoint(x: (x + peakOffset), y: y - h))
            path.addLine(to: CGPoint(x: (x + peakOffset) + peakWidth, y: y))
        }
      
        // Top Right
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius),
                          controlPoint: CGPoint(x: rect.maxX, y: rect.minY))
        
        if selectedPeakSide == .Right {
            let x = rect.maxX
            let y = rect.midY
            path.addLine(to: CGPoint(x: x, y: (y + peakOffset) - peakWidth))
            path.addLine(to: CGPoint(x: x + h, y: (y + peakOffset)))
            path.addLine(to: CGPoint(x: x, y: (y + peakOffset) + peakWidth))
        }
        
        // Bottom Right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY),
                          controlPoint: CGPoint(x: rect.maxX, y: rect.maxY))
        
        if selectedPeakSide == .Bottom {
            let x = rect.minX
            let y = rect.maxY
            path.addLine(to: CGPoint(x: (x + peakOffset) + peakWidth, y: y))
            path.addLine(to: CGPoint(x: (x + peakOffset), y: y + h))
            path.addLine(to: CGPoint(x: (x + peakOffset) - peakWidth, y: y))
        }
        
        //Bottom Left
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius), controlPoint: CGPoint(x: rect.minX, y: rect.maxY))
        
        if selectedPeakSide == .Left {
            let x = rect.minX
            let y = rect.midY
            path.addLine(to: CGPoint(x: x, y: (y + peakOffset) + peakWidth))
            path.addLine(to: CGPoint(x: x - h, y: (y + peakOffset)))
            path.addLine(to: CGPoint(x: x, y: (y + peakOffset) - peakWidth))
        }
        
        
        // Back to start
        path.addLine(to: CGPoint(x: rect.origin.x, y: rect.minY + cornerRadius))
        
        //set and draw stroke color
        strokeColor.setStroke()
        path.stroke()
        
        //set and draw fill color
        fillColor.setFill()
        path.fill()
        
    }
}
