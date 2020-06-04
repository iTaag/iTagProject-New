//
//  ViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 18/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var countryCodeTextfield: UITextField!
    @IBOutlet weak var counrtryCodeBtn: UIButton!
    @IBOutlet weak var mobileNumTextfield: UITextField!
    @IBOutlet weak var restoreView: UIView!
    
    var savedUserId: String?
    var userID: String?
   // var countryList = CountryList()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        restoreView.isHidden = true
        
        countryCodeTextfield.delegate = self
        addDoneButtonOnKeyboard()
        //countryList.delegate = self
        hideKeyboardWhenTappedAround()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != self.restoreView {
            dismissView()
        }
    }
    
    func dismissView() {
        self.restoreView.isHidden = true
        view?.backgroundColor = .white
    }
    
    @IBAction func createNewaccBtn(_ sender: Any) {
            print("in login service")
            //http://itaag.us-east-1.elasticbeanstalk.com/validate/user/bydeviceid
            let URL_HEROES = Constants.GLOBAL_URL + "/validate/user/bydeviceid"
            let url = NSURL(string: URL_HEROES)
            //let deviceId: String = (UIDevice.current.identifierForVendor?.uuidString)!
            //let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

            let headers = ["deviceid": deviceId, "userType": "personal", "key": mobileNumTextfield.text!]
        
            let request = NSMutableURLRequest(url:url! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                if error == nil {
                    let httpResponse = response as? HTTPURLResponse
                    if httpResponse!.statusCode == 200 {
                        do {
                            let jsonObject  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String :AnyObject]
                            print("the json of USERID LOGIN\(jsonObject)")
                            let login = LoginModel.init(fromDictionary: jsonObject)
                            let success    = login.success
                            let userExists = login.userExists
                            print("create new acc \(userExists)")
                            
                            
                            if success == "true" {
                                if userExists == "true" {
                                    DispatchQueue.main.async {
                                        UserDefaults.standard.set(self.mobileNumTextfield.text!, forKey: "PhoneNumber")
                                        UserDefaults.standard.synchronize()
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
                                        viewController.phone = self.mobileNumTextfield.text
                                        self.navigationController?.pushViewController(viewController, animated: true)
                                    }
                                } else {
//                                    DispatchQueue.main.async {
//
//                                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                                    self.navigationController?.pushViewController(viewController, animated: true)
//                                   }
                                    //self.showAlert(title: "", message: "User Exists")
                                }
                            }
                        }
                        catch  {
                            print(error.localizedDescription)
                        }
                    }
                    else {
                        self.showAlert(title: "", message: "Please enter vaild details")
                    }
                }
            })
            dataTask.resume()
        }
    
    @IBAction func restoreAccBtn(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RestoreEmailPhonenumberViewController") as! RestoreEmailPhonenumberViewController
        viewController.phone = self.mobileNumTextfield.text

        self.navigationController?.pushViewController(viewController, animated: true)
        self.restoreView.isHidden = true

    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        mobileNumTextfield.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        mobileNumTextfield.resignFirstResponder()
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        print("in submit")
        
    if sender.tag == 1 {
     if (mobileNumTextfield.text?.count)!<1 {
         Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Mobile Number", on: self)
         return
     }
     self.loginService()
 } else {
      
 }
 }
    func loginService() {
        print("in login service")
        //http://itaag.us-east-1.elasticbeanstalk.com/validate/user/bydeviceid
        let URL_HEROES = Constants.GLOBAL_URL + "/validate/user/bydeviceid/"
        let url = NSURL(string: URL_HEROES)
        let deviceId: String = "HardcodeDEVICEIDforiTaag"
        //let deviceId: String = (UIDevice.current.identifierForVendor?.uuidString)!
        let headers = ["deviceid": deviceId, "userType": "personal", "key": mobileNumTextfield.text!]
        
        
        //let deviceIdL: String=(UIDevice.current.identifierForVendor?.uuidString)!
        print("login deviceid \(deviceId)")
        let request = NSMutableURLRequest(url:url! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
            if error == nil {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse!.statusCode == 200 {
                    do {
                        let jsonObject  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String :AnyObject]
                        print("the json of USERID LOGIN\(jsonObject)")
                        let login = LoginModel.init(fromDictionary: jsonObject)
                        let success    = login.success
                        let userExists = login.userExists
                        
                        UserDefaults.standard.set(userExists, forKey: "userExists")

                        self.savedUserId = KeychainWrapper.standard.string(forKey: "USERID")
                        login.userId = self.savedUserId//login.userId
                        
            if success == "true" {
                            
                if userExists == "false" {
                        DispatchQueue.main.async {
                         UserDefaults.standard.set(self.mobileNumTextfield.text!, forKey: "PhoneNumber")
                            
                            
                          UserDefaults.standard.synchronize()
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
                         viewController.phone = self.mobileNumTextfield.text
                         self.navigationController?.pushViewController(viewController, animated: true)
                        }
                }
                else {
                   // print("login userid saved \(self.savedUserId)")
                    
//                    if self.userID != nil{
                     //   print("login true useriiiii \(self.userID)")
                                 DispatchQueue.main.async {
                                 let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                   self.navigationController?.pushViewController(viewController, animated: true)

                              }
 //                             }
                              
                    //if self.userID == nil{
//                    else{
//                        DispatchQueue.main.async {
//
//                          self.view?.backgroundColor = UIColor(white: 1, alpha: 0.7)
//                          self.restoreView.isHidden = false
//
//                        }
//                    }
//
            }                            
                            
//                            if userExists == "false" {
//                                DispatchQueue.main.async {
//                                    UserDefaults.standard.set(self.mobileNumTextfield.text!, forKey: "PhoneNumber")
//                                    UserDefaults.standard.synchronize()
//                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
//                                    viewController.phone = self.mobileNumTextfield.text
//                                    self.navigationController?.pushViewController(viewController, animated: true)
//                                }
//                            } else {
//                                DispatchQueue.main.async {
//                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                                self.navigationController?.pushViewController(viewController, animated: true)
//                               }
////                               self.showAlert(title: "", message: "User Exists")
////
////                            DispatchQueue.main.async {
////
////                                self.view?.backgroundColor = UIColor(white: 1, alpha: 0.7)
////                                self.restoreView.isHidden = false
////
////                                }
//
//                            }
                        }
                    }
                    catch  {
                        print(error.localizedDescription)
                    }
                }
                else {
                    self.showAlert(title: "", message: "Please enter vaild details")
                }
            }
        })
        dataTask.resume()
    }
}


    /*
 Print values of both userID and savedUserId using optional binding. guard let newUserId = self.userID else { print(“userId not exists”) } print(newUserId) guard let newSavedUserId = self.savedUserId else { print(“newSavedUserId not exists”) } print(newSavedUserId)
 */
