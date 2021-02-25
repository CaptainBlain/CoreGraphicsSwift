//
//  ViewController.swift
//  CoreGraphicsSwift
//
//  Created by Blain Ellis on 25/02/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let speech = SpeechBubble(frame: CGRect(x: 50, y: 50, width: 220, height: 120))
        speech.peakSide = .Bottom
        speech.peakOffset = 150
        speech.text = "Hello this is a tip my firend "
        speech.highlightText = "tip"
        view.addSubview(speech)
    }


}

