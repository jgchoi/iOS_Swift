//
//  AuthorsViewController.swift
//  jgchoi.lab3
//
//  Created by Jung Choi on 2016-02-12.
//  Copyright © 2016 Seneca. All rights reserved.
//

import UIKit

class AuthorsViewController: UITableViewController {
    // MARK: - Properties
    var authors = NSArray( )
    var alphabetizedAuthors = [String:[String]]()
    let cellIdentifier = "Cell Identifier"
    let segueToBooks = "BooksViewController"

    // MARK: - Controller Method
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.classForCoder( ), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        authors = PListHelper.loadPlist()
        alphabetizedAuthors = alphabetize()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let keys = alphabetizedAuthors.keys

        return keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Calling private utility function to get the array of [String] keys in the dictionary
        let sortedLangKeys = getAuthorKey( )
        
        // This now sets "key" to the array of Strings in each dictionary key
        // (i.e. A=>"Algol 68", AppleScript" OR P=>"PHP, Prolog, Python", etc.)
        let key = sortedLangKeys[section]
        
        // Return the number of languages in each "section".
        return alphabetizedAuthors[key] != nil ? alphabetizedAuthors[key]!.count : 0
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Perform Segue
        performSegueWithIdentifier(segueToBooks, sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Get and sort keys
        let keys = getAuthorKey( )

        return keys[section]
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Get and sort the keys
        let keys = getAuthorKey( )
        
        // Capture languages for section at indexPath
        let key = keys[indexPath.section]
        
        if let authorsInKey = alphabetizedAuthors[key] {
            // Get language
            let author = authorsInKey[indexPath.row]
            cell.textLabel!.text = author
        }
        return cell
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueToBooks {
            let indexPath = tableView.indexPathForSelectedRow
            let keys = getAuthorKey( )
            var authorName:String
            
            // Capture languages for section at indexPath
            let key = keys[indexPath!.section]
            
            let authorsInKey = alphabetizedAuthors[key]
                // Get language
                authorName = authorsInKey![indexPath!.row]
            
                let destinationViewController = segue.destinationViewController as! BooksViewController
                destinationViewController.author = getAuthorDicByName(authorName)
            
        }
    }
    
    // MARK: - Methods for Author Sorting
    
    //Receives converted author name for table row (Last, First)
    //Compare author name in the data, returns dictionary object that
    //can be used in books view
    //returns nil if author is not found -- but won't be happen in normal situation
    private func getAuthorDicByName(name:String)->[String: AnyObject]?{
        for author in authors{
            var authorName = author["Author"] as! String
            authorName = convertNameFormat(authorName)
            
            if(authorName == name){
                return author as? [String : AnyObject]
            }
        }
        return nil
    }
    
    //Receives author string and convert format to last, first name
    private func convertNameFormat(authorName:String)->String{
        let lastName = authorName.componentsSeparatedByString(" ").last
        let restName = authorName.componentsSeparatedByString(lastName!).first
        return lastName!+", "+restName!
        
    }
    
    //Method copied from lecture note
    //Slightly modifed
    private func alphabetize() -> [String: [String]] {
        var result = [String: [String]]( )
        
        var authorsWithConvertedName: [String] = [ ]
        
        for author in authors{
            let authorName = author["Author"] as! String
            authorsWithConvertedName.append(convertNameFormat(authorName))
        }
        
        for authorName in authorsWithConvertedName {
            let index = authorName.startIndex.advancedBy(1)
            let firstLetter = authorName.substringToIndex(index).uppercaseString
            
            if result[firstLetter] != nil {
                result[firstLetter]!.append(authorName)
            }
            else {
                result[firstLetter] = [authorName]
            }
        }
        
        for (key, value) in result {
            result[key] = value.sort({ (a, b) -> Bool in a.lowercaseString < b.lowercaseString })
        }
        return result
    }
    
    private func getAuthorKey( ) -> [String] {
        return alphabetizedAuthors.keys.sort({ (a, b) -> Bool in a.lowercaseString < b.lowercaseString })
    }
    

}
