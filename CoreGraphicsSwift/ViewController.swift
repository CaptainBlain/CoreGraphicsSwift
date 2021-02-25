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
        
        let speech = SpeechBubble(frame: CGRect(x: 50, y: 50, width: 220, height: 140))
        view.addSubview(speech)
    }


}

