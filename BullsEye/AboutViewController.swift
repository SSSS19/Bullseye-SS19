//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Shehab Saqib on 24/08/2015.
//  Copyright (c) 2015 Shehab Saqib. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func close()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func webViews()
    {
        if let htmlfile = NSBundle.mainBundle().pathForResource("BullsEye", ofType: "html"){
            let htmlData = NSData(contentsOfFile: htmlfile)
            let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
            webView.loadData(htmlData, MIMEType: "text/html", textEncodingName: "UTD-8", baseURL: baseURL)
        }
    }

}
