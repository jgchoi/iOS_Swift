//
//  DetailTableViewController.swift
//  LCBO Locator
//
//  Created by Jung Geon Choi on 2016. 3. 30..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var store:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: // address, phone
                return 5
        case 1: // hours mon-sun
                return 7
        case 2: // special features
                return 9
        default:
            return 0
        }
    }
/*, \n \(store!["city"] as! String ),  \(store!["postal_code"] as! String ) \n \(store!["telephone"] as! String)"*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        var title = ""
        var value = ""
        switch indexPath.section{
        case 0:
            switch indexPath.row {
            case 0:
                title = "Address"
                value = "\(store!["address_line_1"] as! String)"
            case 1:
                title = "Building/Unit"
                if let add_line_2 = store!["address_line_2"] as? String {
                    value = add_line_2
                }else{
                    value = ""
                }
            case 2:
                title = "City"
                value = "\(store!["city"] as! String)"
            case 3:
                title = "Postal Code"
                value = "\(store!["postal_code"] as! String)"
            case 4:
                title = "Distance"
                let distance = (store!["distance_in_meters"] as! Double)/1000
                value = "\(distance) km"
            case 5:
                title = "Phone Number"
                value = "\(store!["telephone"] as! String)"
            default:
                title = ""
            }
        case 1:
            switch indexPath.row {
            case 0:
                title = "Monday"
                if(store!["monday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["monday_open"] as! Int)/60
                let open_min = (store!["monday_open"] as! Int)%60
                let close_hour = (store!["monday_close"] as! Int)/60
                let close_min = (store!["monday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            case 1:
                title = "Tuesday"
                if(store!["tuesday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["tuesday_open"] as! Int)/60
                let open_min = (store!["tuesday_open"] as! Int)%60
                let close_hour = (store!["tuesday_close"] as! Int)/60
                let close_min = (store!["tuesday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            case 2:
                title = "Wednesday"
                if(store!["wednesday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["wednesday_open"] as! Int)/60
                let open_min = (store!["wednesday_open"] as! Int)%60
                let close_hour = (store!["wednesday_close"] as! Int)/60
                let close_min = (store!["wednesday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            case 3:
                title = "Thursday"
                if(store!["thursday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["thursday_open"] as! Int)/60
                let open_min = (store!["thursday_open"] as! Int)%60
                let close_hour = (store!["thursday_close"] as! Int)/60
                let close_min = (store!["thursday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            case 4:
                title = "Friday"
                if(store!["friday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["friday_open"] as! Int)/60
                let open_min = (store!["friday_open"] as! Int)%60
                let close_hour = (store!["friday_close"] as! Int)/60
                let close_min = (store!["friday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            case 5:
                title = "Saturday"
                if(store!["saturday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["saturday_open"] as! Int)/60
                let open_min = (store!["saturday_open"] as! Int)%60
                let close_hour = (store!["saturday_close"] as! Int)/60
                let close_min = (store!["saturday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            case 6:
                title = "Sunday"
                if(store!["sunday_open"] as! Int == 0){
                    value = "Closed"
                } else {
                let open_hour = (store!["sunday_open"] as! Int)/60
                let open_min = (store!["sunday_open"] as! Int)%60
                let close_hour = (store!["sunday_close"] as! Int)/60
                let close_min = (store!["sunday_close"] as! Int)%60
                value = "\(open_hour):\(open_min)0 - \(close_hour):\(close_min)0"
                }
            default:
                title = ""
            }
        case 2:
            switch indexPath.row {
            case 0:
                title = "Beer Cold Room"
                if(store!["has_beer_cold_room"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 1:
                title = "Bilingual Services"
                if(store!["has_bilingual_services"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 2:
                title = "Parking"
                if(store!["has_parking"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 3:
                title = "Product Consultant"
                if(store!["has_product_consultant"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 4:
                title = "Special Occasion Permits"
                if(store!["has_special_occasion_permits"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 5:
                title = "Trasting Bar"
                if(store!["has_tasting_bar"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 6:
                title = "Transit Access"
                if(store!["has_transit_access"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 7:
                title = "Vintages Corner"
                if(store!["has_vintages_corner"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            case 8:
                title = "Wheelchair Accessability"
                if(store!["has_wheelchair_accessability"] as! Int == 1){
                    value = "YES"
                }else{
                    value = "NO"
                }
            default:
                title = ""
            }

        default:
            title = ""
            
        }
        
        
        cell.textLabel!.text = title
        cell.detailTextLabel!.text = value

        return cell
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0: // address, phone
            return "Contact Info"
        case 1: // hours mon-sun
            return "Business Hours"
        case 2: // special features
            return "Special Features"
        default:
            return ""
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
