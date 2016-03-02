//
//  BookImageController.swift
//  jgchoi.lab3
//
//  Created by Jung Choi on 2016-02-12.
//  Copyright © 2016 Seneca. All rights reserved.
//

import UIKit

class BookImageController: UIViewController {
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    var bookDetails: [String: String]!
    let segueToWeb = "showWeb"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let fileName = bookDetails["Cover"] {
            bookCover.image = UIImage(named: fileName)
            if(bookCover.image == nil){
                bookCover.image = UIImage(named: "defaultImage")
            }
            bookCover.contentMode = .ScaleAspectFit
        }
        
        if let year = bookDetails["Year"] {
            yearLabel.text = "Publisehd on " + year
        }
        
        if let isbn = bookDetails["ISBN"] {
            isbnLabel.text = "ISBN: " + isbn
        }
        
        if let title = bookDetails["Title"] {
            titleLabel.text = title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTouchBookCoverImage(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier(segueToWeb, sender: self)
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == segueToWeb {
                let destinationViewController = segue.destinationViewController as! WebViewController
                destinationViewController.bookISBN = bookDetails["ISBN"]
        }
    }


}
