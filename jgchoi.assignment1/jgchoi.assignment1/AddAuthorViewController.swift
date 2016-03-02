//
//  AddAuthorViewController.swift
//  jgchoi.assignment1
//
//  Created by Jung Geon Choi on 2016. 3. 1..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class AddAuthorViewController: UIViewController {
    var authors = NSMutableArray()
    var path:String?
    @IBAction func save(sender: UIBarButtonItem) {
        processInput(authorNameField)
    }
    
    //Process User Entry
    @IBAction func processInput(sender: UITextField) {
        if(sender.text?.isEmpty == true){
            //Show error if empty
            showAlert()
        }else{
            //Process saving & move back to authors list
            addNewAuthor(sender.text!)
            navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    
    @IBOutlet weak var authorNameField: UITextField!
    
    private func addNewAuthor(author: String){
        authors = loadPlist();
        
        let newAuthor = ["Author": author, "Books": NSArray()] as NSDictionary

        authors.addObject(newAuthor)
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

    
    private func showAlert(){
        let message : String =  "Author name can't be empty"
        let alertController = UIAlertController(title: "Title Empty", message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbar.hidden = false

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
