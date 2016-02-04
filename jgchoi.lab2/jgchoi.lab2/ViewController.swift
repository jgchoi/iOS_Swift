//
//  ViewController.swift
//  jgchoi.lab2
//
//  Created by Jung Geon Choi on 2016-01-29.
//  Copyright © 2016 Jung Geon Choi. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var images:[UIImage] = [];
    var crunchSoundId: SystemSoundID = 0;
    var winnerSoundId: SystemSoundID = 0;
    var MAX = Int(Int16.max)*50
    var money = 25.00
    var bet: Double = 0;
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var moneyAmount: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var bets: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateMoneyAmount()
        changeBetValue(bets)
        
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "banana")!,
            UIImage(named: "melon")!,
            UIImage(named: "orange")!,
            UIImage(named: "lemon")!,
            UIImage(named: "cherry")!,
        ]
    }
    
    func updateMoneyAmount(){
        moneyAmount.text =  String(format: "$ %.2f", money)
    }

    @IBAction func changeBetValue(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            bet = 0.05
        case 1:
            bet = 0.25
        case 2:
            bet = 1.00
        case 3:
            bet = 2.00
        default:
            break;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func processButtonSpin(sender: UIButton) {
        //Deduct bet amount
        money -= bet
//        
//        for i in 0..<7{
//            let newValue = Int(arc4random_uniform(UInt32(MAX)))+1
//            picker.selectRow(newValue, inComponent: i, animated: true)
//        }
//        
        if crunchSoundId == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("crunch", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundId)
        }
        AudioServicesPlaySystemSound(crunchSoundId)
        
        if (isWin()){
            playWinnerSound()
            winLabel.text = "WINNER!!!"
        }
        
        updateBets()
        updateMoneyAmount()
    }
    
    func updateBets(){
        spinButton.enabled = true

        switch money{
        case 0..<0.05:
            bets.setEnabled(false, forSegmentAtIndex: 0)
            bets.setEnabled(false, forSegmentAtIndex: 1)
            bets.setEnabled(false, forSegmentAtIndex: 2)
            bets.setEnabled(false, forSegmentAtIndex: 3)

            spinButton.enabled = false
        case 0.05..<0.25:
            bets.setEnabled(true, forSegmentAtIndex: 0)
            bets.setEnabled(false, forSegmentAtIndex: 1)
            bets.setEnabled(false, forSegmentAtIndex: 2)
            bets.setEnabled(false, forSegmentAtIndex: 3)
            if(bet>money){
                bets.selectedSegmentIndex = 0
                bet = 0.05
            }
        case 0.25..<1.00:
            bets.setEnabled(true, forSegmentAtIndex: 0)
            bets.setEnabled(true, forSegmentAtIndex: 1)
            bets.setEnabled(false, forSegmentAtIndex: 2)
            bets.setEnabled(false, forSegmentAtIndex: 3)
            if(bet>money){
                bets.selectedSegmentIndex = 1
                bet = 0.25
            }
        case 1.00..<2.00:
            bets.setEnabled(true, forSegmentAtIndex: 0)
            bets.setEnabled(true, forSegmentAtIndex: 1)
            bets.setEnabled(true, forSegmentAtIndex: 2)
            bets.setEnabled(false, forSegmentAtIndex: 3)
            if(bet>money){
                bets.selectedSegmentIndex = 2
                bet = 1.00
            }
        default:
            break
            
        }
        if( money > 2.00){
            bets.setEnabled(true, forSegmentAtIndex: 0)
            bets.setEnabled(true, forSegmentAtIndex: 1)
            bets.setEnabled(true, forSegmentAtIndex: 2)
            bets.setEnabled(true, forSegmentAtIndex: 3)

        }
    }
    
    func isWin() ->Bool{
        winLabel.text = String("")
        var spinResult : Array<Int> = [];
        
        for i in 0..<7{
            spinResult.append(picker.selectedRowInComponent(i)%images.count)
        }
        
        var result : Bool = true
        
        //Check for all 7
        for i in 0..<7{
            if(spinResult[i] != 0){
                result = false
            }
        }
        
        if(result){
            money+=1000000
            return true;
        }
        
        //Check for any same 7 itmes
        result = true
        for i in 1..<7{
            for j in 0..<7{
                if(spinResult[j] != i){
                    result = false
                    break
                }
            }
            if(result){
                print("Any 7 items")
                money += bet*1000
                return true
            }
            result = true;
        }
        
        //6*0~6
        for i in 0..<7{
            var counter = 0;
            for j in 0..<7{
                if(spinResult[j] == i){
                    counter++
                }else if(counter != 6){
                    counter = 0
                }
            }
            if(counter == 6){
                money += bet*250
                return true
            }
            counter = 0;
        }
        
        //5*0~6
        for i in 0..<7{
            var counter = 0;
            for j in 0..<7{
                if(spinResult[j] == i){
                    counter++
                }else if(counter != 5){
                    counter = 0
                }
            }
            if(counter == 5){
                money += bet*50
                return true
            }
            counter = 0;
        }
        
        //4 & 3
        if( (spinResult[0] == spinResult[1] &&
            spinResult[1] == spinResult[2] &&
            spinResult[2] == spinResult[3] &&
            spinResult[4] == spinResult[5] &&
            spinResult[5] == spinResult[6] ) ||
            (spinResult[0] == spinResult[1] &&
            spinResult[1] == spinResult[2] &&
            spinResult[3] == spinResult[4] &&
            spinResult[4] == spinResult[5] &&
                spinResult[5] == spinResult[6] )){
                    money += bet*25
                    return true
        }
        
        // 3& 3
        if( (   spinResult[0] == spinResult[1] &&
                spinResult[1] == spinResult[2] &&
                spinResult[3] == spinResult[4] &&
                spinResult[4] == spinResult[5]      ) ||
            (   spinResult[0] == spinResult[1] &&
                spinResult[1] == spinResult[2] &&
                spinResult[4] == spinResult[5] &&
                spinResult[5] == spinResult[6]      ) ||
            (   spinResult[1] == spinResult[2] &&
                spinResult[2] == spinResult[3] &&
                spinResult[4] == spinResult[5] &&
                spinResult[5] == spinResult[6]      )){
            money += bet*8
            return true
        }
        
        //4*0~6
        for i in 0..<7{
            var counter = 0;
            for j in 0..<7{
                if(spinResult[j] == i){
                    counter++
                }else if(counter != 4){
                    counter = 0
                }
            }
            if(counter == 4){
                money += bet*5
                return true
            }
        }

        //3*0~6
        for i in 0..<7{
            var counter:Int = 0;
            for j in 0..<7{
                if(spinResult[j] == i && counter != 3){
                    counter++
                }else if(counter != 3){
                    counter = 0
                }
            }
            if(counter == 3){
                money += bet*1
                return true
            }
        }

        
        return false;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 7
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MAX
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String("")
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let image = images[row % images.count]
        let imageView = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        imageView.image = image
        return imageView
    }
    
    
    func playWinnerSound( ) {
        if winnerSoundId == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winnerSoundId)
        }
        AudioServicesPlaySystemSound(winnerSoundId)
    }

}

