//
//  AuthorsViewController.swift
//  jgchoi.lab3
//
//  Created by Jung Choi on 2016-02-12.
//  Copyright © 2016 Seneca. All rights reserved.
//

import UIKit

class AuthorsViewController: UITableViewController {
    //MARK: - A1 Modifications
    var authors = NSArray( )
    var alphabetizedAuthors = [String:[String]]()
    
    //Load OR Write plist
    private func loadPlist( ) -> NSArray {
        var data = NSArray( )
        
        print(NSHomeDirectory( )) // not required, but used to display the path of your
        // app's Home Directory
        
        // attempt to open "authors.plist" from the application's Documents/ directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("authors.plist")
        
        let fileManager = NSFileManager.defaultManager( )
        // if the file is not available (first access), then open it from the app's
        // mainBundle Resources/ folder:
        
        if(!fileManager.fileExistsAtPath(path)) {
            let plistPath = NSBundle.mainBundle( ).pathForResource("authors", ofType: "plist")
            
            data = NSArray(contentsOfFile: plistPath!)!
            
            do {
                try fileManager.copyItemAtPath(plistPath!, toPath: path)
            } catch let error as NSError {
                // failure
                print("Error copying plist file: \(error.localizedDescription)")
            }
            print("First launch... Default plist file copied...")
            data.writeToFile(path, atomically: true)
        }
        else {
            data = NSArray(contentsOfFile: path)!
        }
        return data
    }
    
    private func alphabetize() -> [String: [String]] {
        var result = [String: [String]]( )
        
        var array: [String] = [ ]
        
        for author in authors{
            let authorName = author["Author"] as! String
            let lastName = authorName.componentsSeparatedByString(" ").last
            let restName = authorName.componentsSeparatedByString(lastName!).first
            
              array.append(lastName!+", "+restName!)
        }

        for item in array {
            let index = item.startIndex.advancedBy(1)
            let firstLetter = item.substringToIndex(index).uppercaseString
            
            if result[firstLetter] != nil {
                result[firstLetter]!.append(item)
            }
            else {
                result[firstLetter] = [item]
            }
        }
        
        for (key, value) in result {
            result[key] = value.sort({ (a, b) -> Bool in a.lowercaseString < b.lowercaseString })
        }
        return result
    }
    
    private func getLangKeys( ) -> [String] {
        return alphabetizedAuthors.keys.sort({ (a, b) -> Bool in a.lowercaseString < b.lowercaseString })
    }
    
    //MARK: - Original From Lab 4
    //let plistPath = NSBundle.mainBundle( ).pathForResource("authors", ofType: "plist")
    //var authors = [AnyObject]( )
    let cellIdentifier = "Cell Identifier"
    let segueToBooks = "BooksViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.classForCoder( ), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        authors = loadPlist()
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
        let sortedLangKeys = getLangKeys( )
        
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
        var keys = getLangKeys( )
        /*
        for i in 0..<keys.count {
        keys[i] += " section..."
        }
        */
        return keys[section]
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        // Dequeue Resuable Cell
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
//        
//        if let author = authors[indexPath.row] as? [String: AnyObject], let name = author["Author"] as? String {
//            // Configure Cell
//            cell.textLabel?.text = name
//        }
//        return cell;
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Get and sort the keys
        let keys = getLangKeys( )
        
        // Capture languages for section at indexPath
        let key = keys[indexPath.section]
        
        if let langs = alphabetizedAuthors[key] {
            // Get language
            let sectionLang = langs[indexPath.row]
            
            // Configure Cell in TableView
            /*
            The text of the textLabel property of the table view cell can now be set to
            the language at a specific row within each section. The UITableViewCell class is a
            UIView subclass and it has a number of subviews. One of these subviews is an instance of
            UILabel which is used to display the name of the programming language in the table view cell.
            */
            cell.textLabel?.text = sectionLang
        }
        return cell

    }




    


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueToBooks {
            let indexPath = tableView.indexPathForSelectedRow
            let keys = getLangKeys( )
            var authorName:String
            
            // Capture languages for section at indexPath
            let key = keys[indexPath!.section]
            
            let langs = alphabetizedAuthors[key]
                // Get language
                authorName = langs![indexPath!.row]
            
                let destinationViewController = segue.destinationViewController as! BooksViewController
                destinationViewController.author = getAuthorByName(authorName)
            
        }
    }
    
    private func getAuthorByName(name:String)->[String: AnyObject]?{
        for author in authors{
            var authorName = author["Author"] as! String
            let lastName = authorName.componentsSeparatedByString(" ").last
            let restName = authorName.componentsSeparatedByString(lastName!).first
            
            authorName = lastName!+", "+restName!
            
            if(authorName == name){
                return author as? [String : AnyObject]
            }
        }
        return nil
    }
    

}
