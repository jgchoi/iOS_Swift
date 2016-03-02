//
//  AddBookViewController.swift
//  jgchoi.assignment1
//
//  Created by Jung Geon Choi on 2016. 3. 1..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    var authors = NSMutableArray()
    var path:String?
    var author: [String: AnyObject]!
    
    @IBOutlet weak var coverImageName: UITextField!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var publicshedYear: UITextField!
    @IBOutlet weak var ISBN: UITextField!

    @IBAction func save(sender: AnyObject) {
        editingDone(coverImageName)
    }

    
    
    @IBAction func editingDone(sender: UITextField) {
        if(coverImageName.text?.isEmpty == true){
            showAlert("Enter cover image name")
        }else if(bookTitle.text?.isEmpty == true){
            showAlert("Enter book title ")
        }else if(publicshedYear.text?.isEmpty == true){
            showAlert("Enter published year")
        }else if(ISBN.text?.isEmpty == true){
            showAlert("Enter ISBN")
        }else{
            addNew()
            navigationController?.popViewControllerAnimated(true)
        }

    }
    
    private func addNew(){
        authors = loadPlist()
        let authorIndex = authors.indexOfObject(author)
        let newBook = ["ISBN": ISBN.text!, "Year": publicshedYear.text!, "Title": bookTitle.text!, "Cover": coverImageName.text!];
        let books = author["Books"] as! [AnyObject]
        let newBooks = NSMutableArray()
        for book in books{
            newBooks.addObject(book)
        }
        newBooks.addObject(newBook)
        author["Books"] = newBooks
        authors[authorIndex] = author
        
        
        authors.writeToFile(path!, atomically: true)
    }
    
   
    
    //Load OR Write plist
    private func loadPlist( ) -> NSMutableArray {
        
        print(NSHomeDirectory( )) // not required, but used to display the path of your
        // app's Home Directory
        
        // attempt to open "authors.plist" from the application's Documents/ directory
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        path = documentsDirectory.stringByAppendingPathComponent("authors.plist")
        
        return NSMutableArray(contentsOfFile: path!)!
    }
    
    private func showAlert(message:String){

        let alertController = UIAlertController(title: "Empty Field", message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverImageName.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
