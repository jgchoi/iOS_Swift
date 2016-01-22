//
//  ViewController.swift
//  jgchoi.lab1
//
//  Created by Jung Geon Choi on 2016-01-22.
//  Copyright © 2016 Jung Geon Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textViewData: UITextView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var label1Name: UILabel!
    @IBOutlet weak var label1Value: UILabel!
    @IBOutlet weak var label2Name: UILabel!
    @IBOutlet weak var label2Value: UILabel!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet weak var sliderCtrl: UISlider!
    
    @IBAction func processButtonPress(sender: UIButton) {
        var myInfo : String =  ""
        myInfo += "Name: Jung Geon Choi\n"
        myInfo += "Student #: 025651134\n"
        myInfo += "Email: jgchoi@myseneca.ca\n"
        myInfo += "App Name: jgchoi.lab1\n"
        myInfo += "Program: BSD\n"
        myInfo += "Course: DPS923\n"
        myInfo += "Semester: 6\n"
        myInfo += "Interest: iOS Development\n"
        myInfo += "Grade Expected: A++"
        
        let alertController = UIAlertController(title: "About Me", message:myInfo, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func processSliderMove(sender: UISlider) {
        let currentValue = Int(sender.value)
        var convertedValue : Double = Double()
        
        switch segmentCtrl.selectedSegmentIndex {
            case 0: convertedValue = Double(currentValue) * 9.0 / 5.0 + 32.0
            case 1: convertedValue = Double(currentValue) / 1.428
            case 2: convertedValue = Double(currentValue) * 2.2
            case 3: convertedValue = Double(currentValue) / 1.6
            default: break
        }
        
        label1Value.text = "\(currentValue)"
        label2Value.text = String(format: "%.2f", convertedValue)
    }
    
    @IBAction func processTextInput(sender: UITextField) {
        let dateFormatter = NSDateFormatter( )
        dateFormatter.dateFormat = "MMM-dd-yyyy HH:mm:ss a zzz"
        let date = NSDate( )
        let dateString = dateFormatter.stringFromDate(date)
        let timeOfDay = dateString[dateString.startIndex.advancedBy(21)...dateString.startIndex.advancedBy(23)]
        var emoticon: String!
        
        if (timeOfDay == "AM"){
             emoticon = "\u{1F31E}"
        }else{
             emoticon = "\u{1F31E}"
        }
        
        textViewData.text = sender.text! + " " + dateString + emoticon!
        textViewData.textColor = UIColor.redColor()
        
        //Ester egg
        if(sender.text!.caseInsensitiveCompare("tim cook")) == NSComparisonResult.OrderedSame{
            photo.image = UIImage(named: "tim.cook.large")
        }else if(sender.text!.caseInsensitiveCompare("steve jobs") == NSComparisonResult.OrderedSame){
            photo.image = UIImage(named: "steve.jobs.large")
        }
    }
    
    @IBAction func proceeSegmentClick(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            label1Name.text = "Temp C:"
            label2Name.text = "Temp F:"
            sliderCtrl.minimumValue = -100
            sliderCtrl.maximumValue = 100
        case 1:
            label1Name.text = "$CDN :"
            label2Name.text = "$US  :"
            sliderCtrl.minimumValue = 0
            sliderCtrl.maximumValue = 1000
        case 2:
            label1Name.text = "Kilos :"
            label2Name.text = "Lbs   :"
            sliderCtrl.minimumValue = 0
            sliderCtrl.maximumValue = 500
        case 3:
            label1Name.text = "Km    :"
            label2Name.text = "Miles :"
            sliderCtrl.minimumValue = 0
            sliderCtrl.maximumValue = 300
        default:
            break;
        }
        
        sliderCtrl.value = 0
        processSliderMove(sliderCtrl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proceeSegmentClick(segmentCtrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

