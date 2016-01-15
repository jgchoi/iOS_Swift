//
//  ViewController.swift
//  hellowWorld
//
//  Created by Jung Geon Choi on 2016. 1. 15..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBAction func process(sender: UITextField) {

        nameLabel.text = "Hello! " + sender.text!;
        let color = UIColor.orangeColor();
        nameLabel.textColor = color;
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

