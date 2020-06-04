//
//  ChangePhoneNumViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 19/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ChangePhoneNumViewController: UIViewController {
    var userModel : ProfileModel?

    @IBOutlet weak var oldPhoneLabel: UILabel!
    
    @IBOutlet weak var PhoneNumTextField: UITextField!
    var newPhoneNum: String?
    var savedNewPhoneNum: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //KeychainWrapper.standard.removeObject(forKey: "RegEmail")

        let storedPhonenum = KeychainWrapper.standard.string(forKey: "RegPhoneNumber") ?? ""
        //let storedEmail = UserDefaults.standard.string(forKey: "RegEmail")
        KeychainWrapper.standard.set(PhoneNumTextField.text!, forKey: "NewPhoneNumber")
        oldPhoneLabel.text = storedPhonenum

    }
    
    @IBAction func backBtn(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        getChangeEmail()
    }
    
    func getChangeEmail(){
        print("in change email")
        
        newPhoneNum = PhoneNumTextField.text ?? ""

        KeychainWrapper.standard.set(PhoneNumTextField.text!, forKey: "NewPhoneNumber")
        print("in change email \(newPhoneNum)")

        let URL_HEROES = Constants.GLOBAL_URL + "/update/updatephone/?newvalue=" + (newPhoneNum ?? "")
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

        //let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""
        
        let headers = ["deviceid": deviceId,"userType": "personal","key": personalId]
        
        print("changPhonenum persnolid \(personalId)")
                let urlStr = NSURL(string:URL_HEROES)
                let request = NSMutableURLRequest(url: urlStr! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = (headers as! [String : String])
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        print(error?.localizedDescription ?? "")
                    } else {
                        let httpResponse = response as? HTTPURLResponse
                        if httpResponse?.statusCode == 200 {
                            if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
                                let phoneOTP = jsonObj?["opt"] as? String
                                
                                print("emailchange JSON OTP: \(String(describing: phoneOTP))")
                                DispatchQueue.main.async {
                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController;
                                viewController.otpChangePhonenum = phoneOTP?.onlyCharacters(charSet: .decimalDigits)
                                self.navigationController?.pushViewController(viewController, animated: true);
                                }
                                
                            }
                        }
                    }
                })
                dataTask.resume()
        }
    
}


//1234512234
