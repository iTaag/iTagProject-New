//
//  TermsAndConditionsViewController.swift
//  iTag
//
//  Created by Vinod on 04/11/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class TermsAndConditionsViewController1: UIViewController {

    @IBOutlet weak var checkMarkBtnOutlet: UIButton!
    @IBOutlet weak var continueBtnOutlet: UIButton!
    var iAgreeBtnClicked:Bool = false
    var status : TermsAndConditionsModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        continueBtnOutlet.isUserInteractionEnabled = false
        continueBtnOutlet.backgroundColor = UIColor.lightGray
        continueBtnOutlet.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func termsAndConditionsBtnAction(_ sender: Any) {
        
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController;
//        switch (sender as AnyObject).tag {
//        case 1:
//            //viewController.titleLabel.text = "Terms of Services"
//            htmlUrlString = "http://itaag.us-east-1.elasticbeanstalk.com/customer/termsofservice.html"
//            break
//        case 2:
//            viewController.titleLabel.text = "Privacy Policy"
//            break
//        case 3:
//            viewController.titleLabel.text = "Rewards Terms of Use"
//            break
//        default:
//            
//            break
//            
//        }
//        
//        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    @IBAction func iAgreeBtnAction(_ sender: Any) {
        if iAgreeBtnClicked == false {
            iAgreeBtnClicked = true
            continueBtnOutlet.isUserInteractionEnabled = true
            continueBtnOutlet.backgroundColor = UIColor(red: 55.0/255.0, green: 191.0/255.0, blue: 207.0/255.0, alpha: 1.0)
            checkMarkBtnOutlet.setImage(UIImage(named: "checkMark"), for: UIControl.State.normal)
        } else {
            iAgreeBtnClicked = false
            continueBtnOutlet.isUserInteractionEnabled = false
            continueBtnOutlet.backgroundColor = UIColor.lightGray
            checkMarkBtnOutlet.setImage(UIImage(named: "unCheckMark"), for: UIControl.State.normal)
        }
    }
    @IBAction func continueBtnAction(_ sender: Any) {
            //let deviceId: String = KeychainWrapper.standard.string(forKey: "DEVICEID") ?? ""

            //let deviceId: String=(UIDevice.current.identifierForVendor?.uuidString)!
            //let deviceId: String = "HardcodeDEVICEIDforiTaag"
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

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
//                        DispatchQueue.main.async {
                            let jsonObj: String = json["Success"] as? String ?? ""
                        //self.status = TermsAndConditionsModel.init(fromDictionary: json)
//                        let tc = TermsAndConditionsModel.init(fromDictionary: json)
//                        let success    = tc.success
                        if jsonObj == "true" {
                      DispatchQueue.main.async {

                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController;
                                UserDefaults.standard.set("NoLogout", forKey:"Signout")
                                self.navigationController?.pushViewController(viewController, animated: true);
//
                        
                        
                      
                        
                        
                        }
                        }
                            else{
                            Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again...", on: self)
                    }
//                    }
//                        else{
//                            Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again...", on: self)
//                        }
                    } catch {
                        print(error.localizedDescription)
                        Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again...", on: self)
                    }
                }
            }).resume()
            

        }
    

}




                    
