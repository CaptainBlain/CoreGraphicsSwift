//
//  SpeechBubble.swift
//  CoreGraphicsSwift
//
//  Created by Blain Ellis on 25/02/2021.
//

import UIKit

@IBDesignable
class SpeechBubble: UIView {

    @IBInspectable var lineWidth: CGFloat = 4 { didSet { setNeedsDisplay() } }
    @IBInspectable var cornerRadius: CGFloat = 8 { didSet { setNeedsDisplay() } }
  
    @IBInspectable var strokeColor: UIColor = #colorLiteral(red: 0.643830955, green: 0.861299932, blue: 0.9850798249, alpha: 1) { didSet { setNeedsDisplay() } }
    @IBInspectable var fillColor: UIColor = #colorLiteral(red: 0.643830955, green: 0.861299932, blue: 0.9850798249, alpha: 1) { didSet { setNeedsDisplay() } }
    
    /// - Parameter peakWidth: The width of the peak on the bubble
    @IBInspectable var peakWidth: CGFloat  = 10 { didSet { setNeedsDisplay() } }
    @IBInspectable var peakHeight: CGFloat = 10 { didSet { setNeedsDisplay() } }
    @IBInspectable var peakOffset: CGFloat = 30 { didSet { setNeedsDisplay() } }
    
    @IBInspectable var text: String  = "" { didSet { setNeedsDisplay() } }
    @IBInspectable var highlightText: String  = "" { didSet { setNeedsDisplay() } }
    
    var textView: UITextView!
    var textStorage: NSTextStorage!
    
    var peakSide: PeakSide = .Left
    enum PeakSide: Int {
            case Top
            case Left
            case Right
            case Bottom
    }

    override func draw(_ rectangle: CGRect) {
                        
        //Add a bounding area so we can fit the peak in the view
        let rect = bounds.insetBy(dx: (peakHeight + lineWidth/2), dy: (peakHeight + lineWidth/2))
        
        drawBubble(rect)
        drawTitle(rect)
        drawTextView(rect)
        drawButton(rect)
        
    }
    
    func drawBubble(_ rect: CGRect) {
        //Peak height
        let h: CGFloat = peakHeight * sqrt(3.0) / 2
        
        //create the path
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        // Start of bubble (Top Left)
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY),
                          controlPoint: CGPoint(x: rect.minX, y: rect.minY))
        
        if peakSide == .Top {
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
        
        if peakSide == .Right {
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
        
        if peakSide == .Bottom {
            let x = rect.minX
            let y = rect.maxY
            path.addLine(to: CGPoint(x: (x + peakOffset) + peakWidth, y: y))
            path.addLine(to: CGPoint(x: (x + peakOffset), y: y + h))
            path.addLine(to: CGPoint(x: (x + peakOffset) - peakWidth, y: y))
        }
        
        //Bottom Left
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius), controlPoint: CGPoint(x: rect.minX, y: rect.maxY))
        
        if peakSide == .Left {
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
    
    func drawTitle(_ rect: CGRect) {

        let attrs = getAttributesDictionary(ForFont: UIFont.helvetica(size: 18.0), color: #colorLiteral(red: 0.3568627451, green: 0.4235294118, blue: 0.4862745098, alpha: 1), andTextAlignment: .left)
        let title = "Tip"
        title.draw(in: rect.insetBy(dx: 10, dy: 10), withAttributes: attrs)
    }
    
    func drawTextView(_ rect: CGRect) {
        
        let attrs = getAttributesDictionary(ForFont: UIFont.helveticaThin(size: 16.0), color: #colorLiteral(red: 0.3568627451, green: 0.4235294118, blue: 0.4862745098, alpha: 1))

        //Instantiate an instance of your custom text storage and initialize it with an attributed string holding the content of the note.
        let attrString = NSMutableAttributedString(string: text, attributes: attrs)
        
        //If we find the text that needs higlighting
        if let substringRange = text.range(of: highlightText) {
            //Get the range
            let nsRange = NSRange(substringRange, in: text)
            let ast = NSMutableAttributedString(string: highlightText, attributes: getAttributesDictionary(ForFont: UIFont.helvetica(size: 16.0), color: #colorLiteral(red: 0.3568627451, green: 0.4235294118, blue: 0.4862745098, alpha: 1)))
            //Updte the string
            attrString.replaceCharacters(in: nsRange, with: ast)
        }
     
        textStorage = NSTextStorage(attributedString: attrString)
      
        // Create a layout manager.
        let layoutManager = NSLayoutManager()
        
        // Create a text container and associate it with the layout manager. Then, associate the layout manager with the text storage.
        let containerSize = CGSize(width: rect.maxX, height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
      
        container.lineFragmentPadding = 0
        container.widthTracksTextView = true

        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)

        let padding = CGSize(width: 10, height: 28)
        let frame = CGRect(x: rect.minX + padding.width, y: rect.minY + padding.height, width: rect.maxX - padding.width - 20, height: rect.maxY - padding.height - 12)
         textView = UITextView(frame: frame, textContainer: container)
        textView.backgroundColor =  .clear
        addSubview(textView)
    }
    
    func drawButton(_ rect: CGRect) {
        
        let size = CGSize(width: 64, height: 34)
        let buttonRect = CGRect(x: rect.maxX - size.width - 10, y: rect.maxY - size.height - 8, width: size.width, height: size.height)
        let path = UIBezierPath(roundedRect: buttonRect, cornerRadius: size.height/2)
                
        //set and draw fill color
        #colorLiteral(red: 0.2274509804, green: 0.6196078431, blue: 0.8666666667, alpha: 1).setFill()
        path.fill()
        
        let attrs = getAttributesDictionary(ForFont: UIFont.helvetica(size: 16.0), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), andTextAlignment: .center)
        let title = "Got it"
        let titleSize = title.getStringSize(for: UIFont.helvetica(size: 16.0), andWidth: size.width)
        title.draw(in: buttonRect.insetBy(dx: 0, dy: size.height/2 - titleSize.height/2), withAttributes: attrs)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        if textView != nil {
            //Add a bounding area so we can fit the peak in the view
            let rect = bounds.insetBy(dx: (peakHeight + lineWidth/2), dy: (peakHeight + lineWidth/2))
            let exclusionPath = buttonPath(rect)
            textView.textContainer.exclusionPaths = [exclusionPath]
        }
    }
    
    func buttonPath(_ rect: CGRect) -> UIBezierPath {
        
        let size = CGSize(width: 100, height: 90)
        let buttonRect = CGRect(x: rect.maxX - size.width, y: rect.maxY - size.height, width: size.width, height: size.height)
        return UIBezierPath(rect: buttonRect)
    }
    
   
    
    func getAttributesDictionary(ForFont font: UIFont, color: UIColor, andTextAlignment textAlignment: NSTextAlignment = .left) -> Dictionary<NSAttributedString.Key, Any> {
        
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        
        return [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle: style]
        
    }
}


