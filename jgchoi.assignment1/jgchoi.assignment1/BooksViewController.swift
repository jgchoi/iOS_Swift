//
//  BooksViewController.swift
//  jgchoi.lab3
//
//  Created by Jung Choi on 2016-02-12.
//  Copyright © 2016 Seneca. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController {
    var author: [String: AnyObject]!
    var books: [AnyObject] {
        get {
            if let books = author["Books"] as? [AnyObject] {
                return books
            }
            else {
                return [AnyObject]( )
            }
        }
    }
    let cellIdentifier = "Cell Identifier"
    let segueToBookImage = "BookImageController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let authorName = author["Author"] as? String {
            title = authorName
        }
        
        tableView.registerClass(UITableViewCell.classForCoder( ), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        updateAuthorInfo()
        tableView.reloadData()
    }
    
    private func updateAuthorInfo(){
        let authors = loadPlist()
        for author in authors{
            if(self.author["Author"] as! String == author["Author"]as! String){
                self.author = author as! [String : AnyObject]
            }
        }
    }
    
    //Load OR Write plist
    private func loadPlist( ) -> NSMutableArray {
        
        print(NSHomeDirectory( )) // not required, but used to display the path of your
        // app's Home Directory
        
        // attempt to open "authors.plist" from the application's Documents/ directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("authors.plist")
        
        return NSMutableArray(contentsOfFile: path)!
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue Resuable Cell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        if let book = books[indexPath.row] as? [String: String], let title = book["Title"] {
            // Configure Cell
            cell.textLabel?.text = title
        }
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Perform Segue
        performSegueWithIdentifier(segueToBookImage, sender: self)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueToBookImage {
            if let indexPath = tableView.indexPathForSelectedRow, let book = books[indexPath.row] as? [String: String]  {
                let destinationViewController = segue.destinationViewController as! BookImageController
                destinationViewController.bookDetails = book
            }
        }
        if segue.identifier == "addNewBook" {
    
                let destinationViewController = segue.destinationViewController as! AddBookViewController
            destinationViewController.author = author
            
        }
    }

}
