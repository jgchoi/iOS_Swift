//
//  ViewController.swift
//  helloworld2
//
//  Created by Jung Geon Choi on 2016. 1. 15..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string:"")
    
    
    @IBAction func onButtonClick(sender: UIButton) {
        firstTextField.canBecomeFirstResponder()
        let color = UIColor.orangeColor()
        nameLabel.textColor = color;
        nameLabel.text = "Hello " + firstTextField.text!
        myUtterance = AVSpeechUtterance(string: nameLabel.text!)
        myUtterance.rate = 0.5
        synth.speakUtterance(myUtterance)
        firstTextField.resignFirstResponder()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

