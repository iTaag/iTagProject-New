//
//  ForgotPasswordViewController.swift
//  LMS
//
//  Created by admin on 11/2/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailIconLabel: UILabel!
    @IBOutlet weak var otpLabel: UILabel!
    @IBOutlet weak var otpView: VPMOTPView!
    var userExists: String?
    var userKey: String?
    var userId: String?
    var phone : String?
    var otp   : String?
    var otpCEmail: String?
    var otpChangePhonenum: String?
    var restorOtp: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationBarButton()
        otpView.otpFieldsCount = 6
        otpView.otpFieldDefaultBorderColor = UIColor.lightGray
        otpView.otpFieldEnteredBorderColor = UIColor(named: "LightPrimaryColor") ?? UIColor.blue
        otpView.otpFieldErrorBorderColor = UIColor.red
        otpView.otpFieldBorderWidth = 1
        otpView.delegate = self
        otpView.shouldAllowIntermediateEditing = false
        otpView.otpFieldSize = 25
        otpView.otpFieldDisplayType = .underlinedBottom
        otpView.otpFieldEntrySecureType=false
        otpView.initializeUI()
//        if phone != nil{
//            emailIconLabel.text = "We have sent an sms with OTP \nto \(phone!)"
//        }
        //emailIconLabel.text = "We have sent an sms with OTP \nto \(phone!)"
        
        otpView.subviews.compactMap({ $0 as? VPMOTPTextField}).forEach { tv in
            tv.addDoneButtonOnKeyboard()
        }
        //otpLabel.text = self.otp
        userExists = UserDefaults.standard.string(forKey: "userExists")
        
        print("create account otp page userexis\(userExists)")
        userId = KeychainWrapper.standard.string(forKey: "USERID")
        print("personalid for change emilin login \(userId)")
        if userId == nil{
        self.getOTPService()
        }
        else if userId == nil && userExists == "true"{
            self.getOTPService()

        }
            else if userId == nil && userExists == "false"{
                self.getOTPService()

            }
        else{
            
            if otpCEmail != nil{
                DispatchQueue.main.async {
                    self.otpLabel.text = self.otpCEmail
                }
            }
            if otpChangePhonenum != nil{
                           DispatchQueue.main.async {
                               self.otpLabel.text = self.otpChangePhonenum
                           }
                       }
            
        }
        hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func changNumButn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        if userId == nil
        {
        self.getOTPService()
        }
        else{
            
        }
        
    }
    
    
    func getOTPService() {
        
        let URL_HEROES = Constants.GLOBAL_URL + "/request/otp/"
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

        //let deviceId: String = "HardcodeDEVICEIDforiTaag"
        URLConnections.postUrl2(URL: URL_HEROES, parameters: [:], parametersHttp: ["deviceid": deviceId, "userType": "personal", "key": phone!], URLResponse: { (response, data, error) in
            if error == nil {
                let httpResponse: HTTPURLResponse=response as! HTTPURLResponse
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200 {
                    if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
                        print("request otp \(jsonObj)")
                        let otp  = jsonObj?["opt"] as? String ?? ""
                        self.otp = otp.onlyCharacters(charSet: .decimalDigits)
                        DispatchQueue.main.async {
                        self.otpLabel.text = otp
                        }
                        print("OTP:-\(self.otp!)")
                    }
                } else {
                    DispatchQueue.main.async {
                        Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
                    }
                }
            }
        }, on: self)
    }
}

extension ForgotPasswordViewController: VPMOTPViewDelegate {
    
    
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return true
    }
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
//    func enterPhonenumOTP(){
//
//    }
//
//
//    func enterEmailOTP(otpString: String){
//            if otp == otpString {
//                //http://itaag.us-east-1.elasticbeanstalk.com/validate/otp/?otp=%@
//                let URL_HEROES = Constants.GLOBAL_URL + "/validate/updateemail/ ?otp=" + otpString
//                //let deviceId: String=(UIDevice.current.identifierForVendor?.uuidString)!
//                //let headers = ["deviceid": deviceId,"userType": "personal","key": phone]
//
//                let headers = ["deviceid": "584D97F-761A-4C24-8C4B-C145A8B8BD75","userType": "personal","key": "9609cc826b0d472faf9967370c095c21"]
//
//                let urlStr = NSURL(string:URL_HEROES)
//                let request = NSMutableURLRequest(url: urlStr! as URL,
//                                                  cachePolicy: .useProtocolCachePolicy,
//                                                  timeoutInterval: 10.0)
//                request.httpMethod = "POST"
//                request.allHTTPHeaderFields = (headers as! [String : String])
//                let session = URLSession.shared
//                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//                    if (error != nil) {
//                        print(error?.localizedDescription ?? "")
//                    } else {
//                        let httpResponse = response as? HTTPURLResponse
//                        if httpResponse?.statusCode == 200 {
//                            if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
//                                let Sucess: String=jsonObj?["Success"] as? String ?? ""
//                                if Sucess == "true" {
//                                    DispatchQueue.main.async {
//                                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController;
//                                        self.navigationController?.pushViewController(viewController, animated: true);
//                                    }
//                                } else {
//                                    DispatchQueue.main.async {
//                                        Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                })
//                dataTask.resume()
//            }
//            else {
//                Constants.showAlertView(alertViewTitle: "", Message: "Please enter correct otp", on: self)
//            }
//            print("OTPString: \(otpString)")
//        }
    

    func enteredOTP(otpString: String) {
        if userId == nil{

        if otp == otpString {
               //userKey = userId//UserDefaults.standard.string(forKey: "USERID")
            
            //http://itaag.us-east-1.elasticbeanstalk.com/validate/otp/?otp=%@
            let URL_HEROES = Constants.GLOBAL_URL + "/validate/otp/?otp=" + otpString
            //let deviceId: String = KeychainWrapper.standard.string(forKey: "DEVICEID") ?? ""
            //let deviceId: String = "HardcodeDEVICEIDforiTaag"
            let deviceId: String = "HardcodeDEVICEIDforiTaag222"

           // let deviceId: String=(UIDevice.current.identifierForVendor?.uuidString)!
            let headers = ["deviceid": deviceId,"userType": "personal","key": phone]
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
                            let userExists: String=jsonObj?["userExists"] as? String ?? ""
//                            if userExists == "false" {
                                DispatchQueue.main.async {
                                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController;
                                    self.navigationController?.pushViewController(viewController, animated: true);
                                }
//                            } else {
//                                DispatchQueue.main.async {
//                                    Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
//                                }
//                            }
                        }
                    }
                }
            })
            dataTask.resume()
            
        }
            else {
                       Constants.showAlertView(alertViewTitle: "", Message: "Please enter correct otp", on: self)
            }
                   //print("OTPString: \(otpString)")
        }
            
        else ///if userId != nil
        {
            if self.otpCEmail == otpString {

            print("in change email validate1111")
                print("emailotppppppp\(self.otpCEmail)")
                let URL_HEROES = Constants.GLOBAL_URL + "/validate/updateemail/?otp=" + otpString
                //let deviceId: String=(UIDevice.current.identifierForVendor?.uuidString)!
                //let headers = ["deviceid": deviceId,"userType": "personal","key": phone]
                //let deviceId: String = KeychainWrapper.standard.string(forKey: "DEVICEID") ?? ""
                //let deviceId: String = "HardcodeDEVICEIDforiTaag"
                let deviceId: String = "HardcodeDEVICEIDforiTaag222"

                let headers = ["deviceid": deviceId,"userType": "personal","key": self.userId]
                
                let urlStr = NSURL(string:URL_HEROES)
                let request = NSMutableURLRequest(url: urlStr! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = (headers as! [String : String])
                let session = URLSession.shared
            print("in change email validate2222")

                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        print(error?.localizedDescription ?? "")
                    } else {
                        print("in change email validate333")

                        let httpResponse = response as? HTTPURLResponse
                        if httpResponse?.statusCode == 200 {
                            if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
                                let Sucess: String=jsonObj?["Success"] as? String ?? ""
                                if Sucess == "true" {
                                    print("in change email validate4444")

                                    DispatchQueue.main.async {
                                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController;
                                        KeychainWrapper.standard.removeObject(forKey: "RegEmail")
                                        print("new email \(KeychainWrapper.standard.string(forKey: "NewEmail"))")
                                        let savedNewEmail: String = KeychainWrapper.standard.string(forKey: "NewEmail") ?? ""
                                        print("forgot \(savedNewEmail)")
                                       // viewController.oldEmailLabel.text = KeychainWrapper.standard.string(forKey: "NewEmail")
                                        KeychainWrapper.standard.set(savedNewEmail, forKey: "RegEmail")
                                        self.navigationController?.pushViewController(viewController, animated: true);
                                        
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
                                    }
                                }
                            }
                        }
                    }
                })
                dataTask.resume()
                
            }
//            else {
//                Constants.showAlertView(alertViewTitle: "", Message: "Please enter correct otp", on: self)
//            }
                
                if self.otpChangePhonenum == otpString {

                           print("in change Phone number validate1111")
                               let URL_HEROES = Constants.GLOBAL_URL + "/validate/updatephone/?otp=" + otpString
                               
                               //let deviceId: String = "HardcodeDEVICEIDforiTaag"
                    let deviceId: String = "HardcodeDEVICEIDforiTaag222"

                               let headers = ["deviceid": deviceId,"userType": "personal","key": self.userId]
                               
                               let urlStr = NSURL(string:URL_HEROES)
                               let request = NSMutableURLRequest(url: urlStr! as URL,
                                                                 cachePolicy: .useProtocolCachePolicy,
                                                                 timeoutInterval: 10.0)
                               request.httpMethod = "POST"
                               request.allHTTPHeaderFields = (headers as! [String : String])
                               let session = URLSession.shared
                           print("in change Phone validate 2222")

                               let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                                   if (error != nil) {
                                       print(error?.localizedDescription ?? "")
                                   } else {
                                       print("in change Phone validate333")

                                       let httpResponse = response as? HTTPURLResponse
                                       if httpResponse?.statusCode == 200 {
                                           if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
                                               let Sucess: String=jsonObj?["Success"] as? String ?? ""
                                               if Sucess == "true" {
                                                   print("in change Phone validate4444")

                                                   DispatchQueue.main.async {
                                                       let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePhoneNumViewController") as! ChangePhoneNumViewController;
                                                       KeychainWrapper.standard.removeObject(forKey: "RegPhoneNumber")
                                                       print("new email \(KeychainWrapper.standard.string(forKey: "NewPhoneNumber"))")
                                                       viewController.savedNewPhoneNum = KeychainWrapper.standard.string(forKey: "NewPhoneNumber")
                                                       print("forgot \(viewController.savedNewPhoneNum)")
                                                      // viewController.oldEmailLabel.text = KeychainWrapper.standard.string(forKey: "NewEmail")
                                                       KeychainWrapper.standard.set(viewController.savedNewPhoneNum!, forKey: "RegPhoneNumber")
                                                       self.navigationController?.pushViewController(viewController, animated: true);
                                                       
                                                   }
                                               } else {
                                                   DispatchQueue.main.async {
                                                       Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
                                                   }
                                               }
                                           }
                                       }
                                   }
                               })
                               dataTask.resume()
                               
                           }
                
                

//        else {
//            Constants.showAlertView(alertViewTitle: "", Message: "Please enter correct otp", on: self)
//        }
        print("OTPString: \(otpString)")
        }
    }
}
extension UITextField {

    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }
    /// Done button callback
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
