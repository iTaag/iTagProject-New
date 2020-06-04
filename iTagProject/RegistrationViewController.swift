//
//  RegistrationViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 18/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import DropDown
import SwiftKeychainWrapper
class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: FloatingTextField!
    
    @IBOutlet weak var lastNameTextField: FloatingTextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var userModel : ProfileModel?
    

    let genderDropDown = DropDown()
    let ageDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDropDown()
        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        hideKeyboardWhenTappedAround()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    
    func setDropDown() {
           genderDropDown.anchorView=genderTextField
           //leaveTypeDropDown.width=200
           genderDropDown.direction = .bottom
           genderDropDown.bottomOffset=CGPoint(x: 0, y: genderTextField.bounds.height)
           genderDropDown.dataSource=["Male", "Female"]
           
           ageDropDown.anchorView=ageTextField
           //leaveTypeDropDown.width=200
           ageDropDown.direction = .any
           ageDropDown.bottomOffset=CGPoint(x: 0, y: ageTextField.bounds.height)
           ageDropDown.dataSource=["20-30", "30-40", "40-50", "50-60", "60-70", "Above 70"]
           
           genderDropDown.selectionAction = {(index, item) in
               self.genderTextField.text=item
           }
           
           ageDropDown.selectionAction = {(index, item) in
               self.ageTextField.text=item
           }
       }
    
    @IBAction func dropDownButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 3:
            genderDropDown.show()
            break
            
        case 4:
            ageDropDown.show()
            break
            
        default:
            genderDropDown.show()
            break
        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
                
//
             self.loginService()
//
//           // self.view.endEditing(true)
//
////            if validation()==true
////            {
////                self.loginService()
////            }
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func loginService() {
        DispatchQueue.main.async {

            if(self.firstNameTextField.text?.isEmpty)!{
                self.showAlertView(alertViewTitle: "", Message: "Please Enter First Name", on: self)
                   }
            else if(self.lastNameTextField.text?.isEmpty)!{
                    self.showAlertView(alertViewTitle: "", Message: "Please Enter Last Name", on: self)
                   }
            
        
        else{
            self.userregistration()

        }
        
        }
        
    }
    func validation() -> Bool {
        
//        if(firstNameTextField.text?.isEmpty)!{
//        self.showAlertView(alertViewTitle: "", Message: "Please Enter First Name", on: self)
//        }
//         else if(lastNameTextField.text?.isEmpty)!{
//            self.showAlertView(alertViewTitle: "", Message: "Please Enter Last Name", on: self)
//        }
//        else if isValidEmailAddress(emailAddressString: emailTextField.text!)==false
//            {
//            self.showAlertView(alertViewTitle: "", Message: "Please Enter Valid Email", on: self)
//            }
//

//                if (firstNameTextField.text?.count)!<1 {
//                    self.showAlertView(alertViewTitle: "", Message: "Please Enter First Name", on: self)
//
//                    return false
//                }
//
//                else if (lastNameTextField.text?.count)!<1 {
//                    self.showAlertView(alertViewTitle: "", Message: "Please Enter Last Name", on: self)
//
//                    return false
//                }
//                else if isValidEmailAddress(emailAddressString: emailTextField.text!)==false {
//                    self.showAlertView(alertViewTitle: "", Message: "Please Enter Valid Email", on: self)
//
//                    return false
//        }
        
        return true
    }
    func showAlertView(alertViewTitle title: String, Message message: String, on controller: UIViewController)
    {
        var title1=title
        
        if title1.count<1 {
            title1="Alert"
        }
        
        let alertView = UIAlertController(title: title1, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alertView, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if  (textField == self.emailTextField){
        
        if isValidEmailAddress(emailAddressString: emailTextField.text!)==false
                    {
                    self.showAlertView(alertViewTitle: "", Message: "Please Enter Valid Email", on: self)
                    }

        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//    if  textField == self.emailTextField {
//        DispatchQueue.main.async {
//print("in email begining")
//            if self.isValidEmailAddress(emailAddressString: self.emailTextField.text!)==false
//                       {
//                       self.showAlertView(alertViewTitle: "", Message: "Please Enter Valid Email", on: self)
//                       }
//           }
//        }

    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func userregistration() {
        //let deviceId: String = KeychainWrapper.standard.string(forKey: "DEVICEID") ?? ""
        //let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

        //let deviceId: String = (UIDevice.current.identifierForVendor?.uuidString)!
        let phone: String    = UserDefaults.standard.value(forKey: "PhoneNumber") as! String
        let headers = ["deviceid": deviceId,"userType": "personal","key": phone ]
        let parameters: [String: Any] = [
            "firstName": firstNameTextField.text!,
            "lastName": lastNameTextField.text as Any,
            "email": emailTextField.text as Any,
            "gender": genderTextField.text as Any,
            "ageGroup": ageTextField.text as Any
        ]
        //UserDefaults.standard.set(self.emailTextField.text!, forKey: "RegEmail")
        
        let URL_HEROES = Constants.GLOBAL_URL + "/register/"
        let url = URL (string: URL_HEROES)
        var _ : NSError?
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let postData = String(format: "registrationdetails=%@",jsonString) .data(using: .utf8)
        request.httpBody = postData
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse! as Any)
                
                if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
                    if (jsonObj?.count)!<1
                    {
                        DispatchQueue.main.async {
                            Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
                        }
                    }
                    else {
                        let httpResponse: HTTPURLResponse=response as! HTTPURLResponse
                        print(httpResponse.statusCode)
                        if httpResponse.statusCode == 200 {
                            let userID: String=jsonObj?["userId"] as? String ?? ""

                            DispatchQueue.main.async {

                                KeychainWrapper.standard.set(userID, forKey: "USERID")
                                KeychainWrapper.standard.set(phone, forKey: "RegPhoneNumber")

                                KeychainWrapper.standard.set(self.emailTextField.text!, forKey: "RegEmail")

                            //UserDefaults.standard.set(userID, forKey:"USERID")RegPhoneNumber
                            }
                            print("registration userid \(userID)")
                            if userID.isEmpty {
                                print(userID)
                            }
                            else {
                                DispatchQueue.main.async {
                                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController1") as! RegistrationViewController1

                                    self.navigationController?.pushViewController(viewController, animated: true);
                                }
                            }
                            print(jsonObj as Any)
                        }
                        else {
                            Constants.showAlertView(alertViewTitle: "", Message: "OTP not yet validated", on: self)
                        }
                    }
                }
            }
        })
        dataTask.resume()
        
        
    }
}









