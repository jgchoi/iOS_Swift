//
//  ViewController.swift
//  jgchoi_PARTA
//
//  Created by Jung Geon Choi on 2016. 3. 11..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var pickedNumbers:[Int] = []

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var labels: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func play(sender: UIButton) {
        var newNumbers:[Int] = []
        for i in 1..<50 {
            newNumbers.append(i)
        }
        var picked:[Int] = []
        for _ in 0...5{
            let index = Int(arc4random_uniform(UInt32(newNumbers.count)))
            picked.append(newNumbers.removeAtIndex(index))
        }

        pickedNumbers = picked.sort(<)

        var i = 0
        for label in labels{
            
            label.text = String(pickedNumbers[i++])
        }

    }
    
    @IBAction func checkForWin(sender: UIButton) {
        let urlString = "https://scs.senecac.on.ca/~danny.abesdris/numbers.plist"
        let URL = NSURL(string: urlString)
        let result = NSArray(contentsOfURL: URL!)
        
        var matchedNumbers:[Int] = []
        
        for number in pickedNumbers{
            if(result!.containsObject(number)){
                matchedNumbers.append(number)
            }
        }
        
        if(matchedNumbers.isEmpty){
            textView.text = "No Match Found"
        }
        else{
            textView.text = "Matched \(matchedNumbers.count) ( "
            for number in matchedNumbers{
                textView.text.appendContentsOf("\(number) ")
            }
            textView.text.appendContentsOf(")")
        }
        
        
    }
}

