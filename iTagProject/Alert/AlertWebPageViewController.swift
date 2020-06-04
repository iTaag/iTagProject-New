//
//  AlertWebPageViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 28/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import WebKit
class AlertWebPageViewController: UIViewController {

    @IBOutlet weak var alertVideos: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string: "https://www.youtube.com/watch?v=wZl_gUUClCs")
        let youtubeRequest = URLRequest(url: myURL!)
        alertVideos.load(youtubeRequest)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
