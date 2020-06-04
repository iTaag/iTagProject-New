//
//  RestoreEmailPhonenumberViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 15/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class RestoreEmailPhonenumberViewController: UIViewController {

    
    
    @IBOutlet weak var emailphnumTextfield: FloatingTextField!
    
    var phone : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func submitBtn(_ sender: Any) {
        loginService()
    }
    

        func loginService() {
            print("in login service")
            //http://itaag.us-east-1.elasticbeanstalk.com/validate/user/bydeviceid
            let URL_HEROES = Constants.GLOBAL_URL + "/forgot/emailpwd/" //"/validate/user/bydeviceid/"
            let url = NSURL(string: URL_HEROES)//HardcodeDEVICEIDforiTaag
            //let deviceId: String = (UIDevice.current.identifierForVendor?.uuidString)!
            
            let deviceId: String = "HardcodeDEVICEIDforiTaag222"

            let headers = ["deviceid": deviceId, "userType": "personal", "key": emailphnumTextfield.text!]
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
                            print("the json for re new account\(jsonObject)")
                            let otpRecover = jsonObject["opt"]
                            print("recoveryOTP \(otpRecover)")
                            DispatchQueue.main.async {
                         UserDefaults.standard.set(self.emailphnumTextfield.text!, forKey: "PhoneNumber")
                         UserDefaults.standard.synchronize()
                            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
                            viewController.phone = self.emailphnumTextfield.text
                                //restorOtp
                                viewController.restorOtp = otpRecover as! String

                            self.navigationController?.pushViewController(viewController, animated: true)
                                
                            }
//                            let login = LoginModel.init(fromDictionary: jsonObject)
//                            let success    = login.success
//                            let userExists = login.userExists
//                            if success == "true" {
//                                if userExists == "false" {
//                                    DispatchQueue.main.async {
//                                        UserDefaults.standard.set(self.emailphnumTextfield.text!, forKey: "PhoneNumber")
//                                        UserDefaults.standard.synchronize()
//                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
//                                        viewController.phone = self.emailphnumTextfield.text
//                                        self.navigationController?.pushViewController(viewController, animated: true)
//                                    }
//                                } else {
//    //                                DispatchQueue.main.async {
//    //
//    //                                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//    //                                self.navigationController?.pushViewController(viewController, animated: true)
//    //                                }
//                                    //self.showAlert(title: "", message: "User Exists")
//
//
//                                }
//                            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
