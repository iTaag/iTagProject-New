//
//  TermsandConditionsViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 14/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class TermsandConditionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func continueButton(_ sender: Any) {
            //let deviceId: String = KeychainWrapper.standard.string(forKey: "DEVICEID") ?? ""
             let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!

            //let deviceId: String=(UIDevice.current.identifierForVendor?.uuidString)!
            let phone: String = UserDefaults.standard.value(forKey: "PhoneNumber") as! String
            let headers = [ "deviceid": deviceId,"userType": "personal","key": phone]

            let urlString = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/register/userconsent/?consentAccepted=true"
            guard let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            urlRequest.httpMethod =  "POST"
            urlRequest.allHTTPHeaderFields = headers
            URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) -> Void in
                if error == nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                        print("terms and condition JSON \(json)")
                        //self.status = TermsAndConditionsModel.init(fromDictionary: json)
                        let tc = TermsAndConditionsModel.init(fromDictionary: json)
                        let success    = tc.success
                        if success == true {
                            DispatchQueue.main.async {
                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController;
                                UserDefaults.standard.set("NoLogout", forKey:"Signout")
                                //UserDefaults.standard.set(addressID, forKey:"ADDRESSID")
                                self.navigationController?.pushViewController(viewController, animated: true);
                            }
                        } else{
                            Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again...", on: self)
                        }
                    } catch {
                        print(error.localizedDescription)
                        Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again...", on: self)
                    }
                }
            }).resume()
            
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
