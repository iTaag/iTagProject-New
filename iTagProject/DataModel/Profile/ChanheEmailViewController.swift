//
//  ChanheEmailViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 19/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ChanheEmailViewController: UIViewController {
    var userModel : ProfileModel?

    @IBOutlet weak var oldEmailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    var newEmail: String?
    var savedNewEmail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //KeychainWrapper.standard.removeObject(forKey: "RegEmail")

        let storedEmail = KeychainWrapper.standard.string(forKey: "RegEmail") ?? ""
        //let storedEmail = UserDefaults.standard.string(forKey: "RegEmail")
        KeychainWrapper.standard.set(emailTextField.text!, forKey: "NewEmail")
        oldEmailLabel.text = storedEmail

        //oldEmailLabel.text = storedEmail
//        newEmail = emailTextField.text ?? ""
//        if storedEmail == nil{
//            oldEmailLabel.text = savedNewEmail//emailTextField.text
//        }else{
//            oldEmailLabel.text = storedEmail
//        }
        
        // Do any additional setup after loading the view.
        //getChangeEmail()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        getChangeEmail()
    }
    
    func getChangeEmail(){
        print("in change email")
        
        newEmail = emailTextField.text ?? ""

        KeychainWrapper.standard.set(emailTextField.text!, forKey: "NewEmail")
        print("in change email \(newEmail)")

        let URL_HEROES = Constants.GLOBAL_URL + "/update/updateemail/?newvalue=" + (newEmail ?? "")
        //let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

    
        let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""
        
        let headers = ["deviceid": deviceId,"userType": "personal","key": personalId]
        
        //KeychainWrapper.standard.removeObject(forKey: "ChangEmailPersonalId")
        KeychainWrapper.standard.set(personalId, forKey: "ChangEmailPersonalId")
         
        
        print("changeemail persnolid \(personalId)")
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
                                let emailOTP = jsonObj?["opt"] as? String
                                
                                print("emailchange JSON OTP: \(String(describing: emailOTP))")
                                DispatchQueue.main.async {
                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController;
                                viewController.otpCEmail = emailOTP?.onlyCharacters(charSet: .decimalDigits)
                                self.navigationController?.pushViewController(viewController, animated: true);
                                }
                                
                            }
                        }
                    }
                })
                dataTask.resume()
        }
    
}
