//
//  AddBookViewController.swift
//  jgchoi.assignment1
//
//  Created by Jung Geon Choi on 2016. 3. 1..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    var author: [String: AnyObject]!
    
    @IBOutlet weak var coverImageName: UITextField!
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var publicshedYear: UITextField!
    @IBOutlet weak var ISBN: UITextField!

    @IBAction func save(sender: AnyObject) {
        //When save button touched, check fields
        //Parameter doesn't matter
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
            addNewBook()
            navigationController?.popViewControllerAnimated(true)
        }

    }
    
    private func addNewBook(){
        let authors = PListHelper.loadMutablePlist()
        let authorIndex = authors.indexOfObject(author)
        let newBook = ["ISBN": ISBN.text!, "Year": publicshedYear.text!, "Title": bookTitle.text!, "Cover": coverImageName.text!];
        let books = NSMutableArray(array:author["Books"] as! [AnyObject])
        books.addObject(newBook)
        author["Books"] = books
        authors[authorIndex] = author
        PListHelper.writeToFile(authors)
    }
    
    
    private func showAlert(message:String){

        let alertController = UIAlertController(title: "Empty Field Found", message:message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverImageName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
