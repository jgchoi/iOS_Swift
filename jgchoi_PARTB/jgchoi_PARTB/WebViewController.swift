//
//  WebViewController.swift
//  jgchoi_PARTB
//
//  Created by Jung Geon Choi on 2016. 3. 11..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var url:String?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        // load web site into web view
        url = "http://"+url!
        let myURL = NSURL(string: url!)
        let myURLRequest:NSURLRequest = NSURLRequest(URL: myURL!)
        webView.loadRequest(myURLRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //---- Web View Delegated methods
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
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
