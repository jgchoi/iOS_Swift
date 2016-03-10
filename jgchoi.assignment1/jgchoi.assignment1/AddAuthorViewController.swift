//
//  AddAuthorViewController.swift
//  jgchoi.assignment1
//
//  Created by Jung Geon Choi on 2016. 3. 1..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class AddAuthorViewController: UIViewController {

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
        let authors = PListHelper.loadMutablePlist()
        
        let newAuthor = ["Author": author, "Books": NSArray()] as NSDictionary
        
        authors.addObject(newAuthor)
        PListHelper.writeToFile(authors)
    }
    
       private func showAlert(){
        let message : String =  "Author name can't be empty"
        let alertController = UIAlertController(title: "Title Empty", message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
