//
//  Constant.swift
//  MiHIN
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    
    //static let GLOBAL_URL="http://192.168.0.248:4003/api"
    
    //static let GLOBAL_URL="http://3.83.95.179:4003/api"
    
    static let GLOBAL_URL = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com"//"http://itaag.us-east-1.elasticbeanstalk.com"
    
    //static let GLOBAL_URL="http://192.168.0.248:4003/api"
    
    //static let GLOBAL_URL="http://52.207.213.105:4001/api"
    
    class func showAlertView1(alertViewTitle title: String, Message message: String, on controller: UIViewController, Success: @escaping(_ status: String) -> Void)
    {
        var title1=title
        
        if title1.count<1 {
            title1="Alert"
        }
        let alertView = UIAlertController(title: title1, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            DispatchQueue.main.async {
                Success("success")
            }
        }))
        
        controller.present(alertView, animated: true, completion: nil)
    }
    
    class func showAlertView(alertViewTitle title: String, Message message: String, on controller: UIViewController)
    {
        var title1=title
        
        if title1.count<1 {
            title1="Alert"
        }
        
        let alertView = UIAlertController(title: title1, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alertView, animated: true, completion: nil)
    }
    
    class func printLog(message: Any)
    {
        print(message)
    }
}
