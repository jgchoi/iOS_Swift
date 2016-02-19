//
//  ViewController.swift
//  jgchoi.lab4
//
//  Created by Jung Geon Choi on 2016. 2. 19..
//  Copyright © 2016년 Jung Geon Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    //---- Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var fastForwardButton: UIBarButtonItem!
    @IBOutlet weak var rewindButton: UIBarButtonItem!
    @IBOutlet weak var webView: UIWebView!
    
    
    
    //---- Outlet Actions
    @IBAction func didTouchFastForward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func didTouchRefresh(sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func didTouchStop(sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    
    @IBAction func didtouchRewind(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    //---- Web View Delegated methods
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
        
        // Update Buttons
        fastForwardButton.enabled = webView.canGoForward
        rewindButton.enabled = webView.canGoBack
    }
    
    //---- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        // load web site into web view
        let myURL = NSURL(string: "http://www.amazon.ca")
        let myURLRequest:NSURLRequest = NSURLRequest(URL: myURL!)
        webView.loadRequest(myURLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

