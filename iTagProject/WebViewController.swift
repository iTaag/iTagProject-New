//
//  WebViewController.swift
//  iTag
//
//  Created by Vinod on 04/11/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import WebKit

var htmlUrlString: String? = ""
class WebViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webViewData: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let webViewData = WKWebView()
//        let url = URL(string: htmlUrlString!)!
//        webViewData.load(URLRequest(url: url))
//        webViewData.allowsBackForwardNavigationGestures = true
        
        let myURLString = "http://itaag.us-east-1.elasticbeanstalk.com/customer/termsofservice.html"
        let url = URL(string: myURLString)
        let request = URLRequest(url: url!)
        webViewData.load(request)
    }
    
}
