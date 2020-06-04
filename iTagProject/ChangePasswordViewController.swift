//
//  ForgotPasswordViewController.swift
//  MiHIN
//
//  Created by admin on 11/2/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailIconLabel: UILabel!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var phoneIconLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var loginBgView: UIView!
    @IBOutlet weak var upperCaseLetterLabel: UILabel!
    @IBOutlet weak var lowerCaseLetterLabel: UILabel!
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var specialCharLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var usenameField: UITextField!
    @IBOutlet weak var bgColorView: GRView!
    
    var isView: String!
    
    var userId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationBarButton()
        
        loginBgView.isHidden=true
        
        upperCaseLetterLabel.font = UIFont(name: "fontawesome", size: 12)
        upperCaseLetterLabel.text="* At least one uppercase letter \u{f00d}"
        
        lowerCaseLetterLabel.font = UIFont(name: "fontawesome", size: 12)
        lowerCaseLetterLabel.text="* At least one lowercase letter \u{f00d}"
        
        digitLabel.font = UIFont(name: "fontawesome", size: 12)
        digitLabel.text="* At least one digit \u{f00d}"
        
        specialCharLabel.font = UIFont(name: "fontawesome", size: 12)
        specialCharLabel.text="* At least one special character \u{f00d}"
        
        lengthLabel.font = UIFont(name: "fontawesome", size: 12)
        lengthLabel.text="* Minimum six in length \u{f00d}"
        
        passwordField.delegate=self
        
//        let url1: String="https://blockchain.icrea.com/reset-password/$Ashok icrea$klw4UviJl4r2ayqqVgNCGw=="
//
//        let urlArr = url1.components(separatedBy: "/")
//
//        let url2=urlArr[urlArr.count-1]
//
//        let urlArr1 = url2.components(separatedBy: "$")
//
//        let username=urlArr1[urlArr1.count-2]
//        userId="\(urlArr1[urlArr1.count-1])"
        
        let userName=UserDefaults.standard.value(forKey: "AccountName")
        
        usenameField.text=userName as? String
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true;
    }
    
    func navigationBarButton() {
        backButton.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
        backButton.setTitle(" \u{f104}", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(self.backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
        
        emailIconLabel.font = UIFont(name: "fontawesome", size: 20)
        emailIconLabel.text=" \u{f003}"
        emailIconLabel.textColor=UIColor.lightGray
    }
    
    @objc func backButtonClicked(sender:UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        let sc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        
        let appDelegate = UIApplication.shared.delegate
        
        let window:UIWindow=((appDelegate?.window)!)!
        
        window.rootViewController=UINavigationController(rootViewController: sc!)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if (passwordField.text?.count)!<1 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Password", on: self)
            
            return
        }
        
        else if (confirmPasswordField.text?.count)!<1 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Confirm password", on: self)
            
            return
        }
        
        else if passwordField.text != confirmPasswordField.text {
            Constants.showAlertView(alertViewTitle: "", Message: "Password should match", on: self)
            
            return
        }
        
        else if isValidPassword(testStr: passwordField.text)==false
        {
            //Constants.showAlertView(alertViewTitle: "", Message: "\(upperCaseLetterLabel.text ?? "") \n \n\(lowerCaseLetterLabel.text ?? "") \n \n\(digitLabel.text ?? "") \n \n\(specialCharLabel.text ?? "") \n \n\(lengthLabel.text ?? "")", on: self)
            
            Constants.showAlertView(alertViewTitle: "", Message: "Your password should match with password policy.", on: self)
        }
        
        else
        {
            //self.changePasswordService()
        }
    }
    
    func changePasswordService()
    {
        //let userId1: String?="\(UserDefaults.standard.value(forKey: "UserId") ?? "")"
        
        let userId1: String?="\(UserDefaults.standard.value(forKey: "Username") ?? "")"
        
        let email=userId1 ?? ""
        
        let url:String="\(Constants.GLOBAL_URL)/patient/PatientChangePassword"
        
        URLConnections.postUrl1(URL: url, parameters: ["patientemail": email.lowercased(), "password": passwordField.text ?? ""], URLResponse: { (response, data, error) in
            guard let httpResponse=response as? HTTPURLResponse else{
                return
            }
            
            if httpResponse.statusCode==200
            {
                Constants.showAlertView1(alertViewTitle: "Success", Message: "We have successfully update your account with new password.", on: self, Success: {(success) in
                    DispatchQueue.main.async {
                            UserDefaults.standard.set("", forKey: "Register")
                            UserDefaults.standard.synchronize()
                            
                            DispatchQueue.main.async {
//                                let viewController:MainViewController=self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController;
//                                
//                                viewController.transitioningDelegate=self as? UIViewControllerTransitioningDelegate
//                                
//                                self.navigationController?.pushViewController(viewController, animated: true);
                                //});
                            }
                            return
                        //self.navigationController?.popViewController(animated: true)
                    }
                })
            }
            if httpResponse.statusCode==400
            {
                Constants.showAlertView(alertViewTitle: "", Message: "Please enter registered email", on: self)
            }
                
            else
            {
                Constants.showAlertView(alertViewTitle: "\(httpResponse.statusCode)", Message: "Please try again", on: self)
            }
            
            //                guard let reponseDict=try? JSONSerialization.data(withJSONObject: data!, options: []) else{
            //                    return
            //                }
            //
            //                if (reponseDict is NSDictionary)
            //                {
            //
            //                }
        }, on: self)
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // at least one special character
        // minimum six in length
        
        var timer=Timer()
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        let passwordTest1 = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        let passwordTest2 = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        let passwordTest3 = NSPredicate(format: "SELF MATCHES %@", ".*[!@#$&*]+.*")
        //let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,}")
        
        upperCaseLetterLabel.text="* At least one uppercase letter \u{f00d}"
        lowerCaseLetterLabel.text="* At least one lowercase letter \u{f00d}"
        digitLabel.text="* At least one digit \u{f00d}"
        specialCharLabel.text="* At least one special character \u{f00d}"
        lengthLabel.text="* Minimum six in length \u{f00d}"
        
        if passwordTest.evaluate(with: testStr)==true {
            upperCaseLetterLabel.text="* At least one uppercase letter \u{f00c}"
        }
        
        if passwordTest1.evaluate(with: testStr)==true {
            lowerCaseLetterLabel.text="* At least one lowercase letter \u{f00c}"
        }
        
        if passwordTest2.evaluate(with: testStr)==true {
            digitLabel.text="* At least one digit \u{f00c}"
        }
        
        if passwordTest3.evaluate(with: testStr)==true {
            specialCharLabel.text="* At least one special character \u{f00c}"
        }
        
        if (testStr?.count)!>5 {
            lengthLabel.text="* Minimum six in length \u{f00c}"
        }
        
        if  passwordTest.evaluate(with: testStr)==true && passwordTest1.evaluate(with: testStr)==true && passwordTest2.evaluate(with: testStr)==true && passwordTest3.evaluate(with: testStr)==true && (testStr?.count)!>5{
            return true
        }
        
        else
        {
        return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var name=textField.text ?? ""
        
        var text:String="\(name)\(string)"
        
        if string.count==0 {
            if (name.count)>0
            {
                _=name.remove(at: (name.index(before: (textField.text?.endIndex)!)))
            }
            
            text="\(name)"
        }
        
        self.isValidPassword(testStr: text)
        
        return true
    }
}
