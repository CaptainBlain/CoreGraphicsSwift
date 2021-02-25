//
//  Extension+String.swift
//  CoreGraphicsSwift
//
//  Created by Blain Ellis on 25/02/2021.
//

import UIKit

extension String {
    
    func getStringSize(for font: UIFont, andWidth width: CGFloat) -> CGSize {
        
        // calculate text height
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [
                                                NSAttributedString.Key.font: font],
                                            context: nil)
        let width = ceil(boundingBox.width)
        let height = ceil(boundingBox.height)
        
        return CGSize(width: width, height: height)
    }
}
