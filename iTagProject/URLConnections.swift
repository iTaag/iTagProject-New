//
//  URLConnections.swift
//  NJHIN
//
//  Created by admin on 1/31/18.
//  Copyright © 2018 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

import MBProgressHUD

import SystemConfiguration

var selfView = UIView()
var selfViewController = UIViewController()

var urlString:String?

var parametersDictionary=[String:Any]()

var window=UIWindow()

class URLConnections: NSObject {
    class func getURL(URL url: String, Response: @escaping(_ reponse: [String: Any]) -> Void, ResponseArray: @escaping(_ response: NSArray) -> Void, statusCode: @escaping(_ statusCode: Int) -> Void, Error: @escaping(_ error: Error?) -> Void, on viewController: UIViewController){
        let HUD = MBProgressHUD()
        
        let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
        
        window=((appDelegate.window)!)
        
        if let view1=viewController.view{
            selfView=view1
            selfViewController=viewController
        }
            
        else
        {
            selfView=(window.rootViewController?.view)!
            selfViewController=UIViewController()
        }
        
        urlString=url
        
        if Reachability.isConnectedToNetwork(){
            //Constants.printLog(message: "Internet Connection Available!")
        }else{
            Constants.showAlertView(alertViewTitle: "", Message: "Internet Connection not Available!", on: selfViewController)
            
            return
            
            //Constants.printLog(message: "Internet Connection not Available!")
        }
        
        DispatchQueue.main.async {
            HUD.mode=MBProgressHUDMode.indeterminate
            HUD.label.text="Loading"
            HUD.label.textColor = UIColor.darkGray
            
            MBProgressHUD.showAdded(to: window, animated: true)
        }
        
        
        //        let url1 = NSURL(string: url)
        //
        //        Constants.printLog(message: url1 ?? "")
        
        guard let url1=URL(string: url) else{
            return
        }
        var request=URLRequest(url: url1)
        
        request.httpMethod="GET"
        
        let URL_HEROES = "\(Constants.GLOBAL_URL)/patient/refresh-signIn";
        
        if url==URL_HEROES {
            
        }
            
//        else if let title=accessToken {
//            request.setValue("Authorization", forHTTPHeaderField: "Accept")
//
//            //let userIdDcrpt: String=UserDefaults.standard.value(forKey: "UserId") as! String
//
//            let userIdDcrpt: String=appDelegate.userId!
//
//            let userId=try! userIdDcrpt.saveAesDecrypt()
//
//            let user: String=String(userId)
//
//            let userID=self.encription(value: user)
//
//            request.setValue("Bearer \(title)USER\(userID)", forHTTPHeaderField: "Authorization")
//        }
        
        //URLSession.shared.dataTask(with: (url1 as URL?)!) { (data, response, error) in
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let URL_HEROES = "\(Constants.GLOBAL_URL)/patient/adtMessage-status";
                    
                    if url.contains(URL_HEROES) {
                        Constants.printLog(message: "url: \(urlString ?? "") \(httpResponse.statusCode)")
                        
                        statusCode(httpResponse.statusCode)
                        
                        return
                    }
                    
                    statusCode(httpResponse.statusCode)
                    
                    if httpResponse.statusCode==401
                    {
                        return
                    }
                    
                    Constants.printLog(message: "url: \(urlString ?? "") \(httpResponse.statusCode)")
                    
                    if setStatusCode(statusCode: httpResponse.statusCode)==true
                    {
                        guard let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: []) else{
                            DispatchQueue.main.async {
                                MBProgressHUD.hide(for: window, animated: true)
                            }
                            
                            Error(error)
                            
                            return
                        }
                        
                        if (jsonDict is NSDictionary){
                            Response(jsonDict as! [String: Any])
                        }
                            
                        else if (jsonDict is NSArray){
                            ResponseArray(jsonDict as! NSArray)
                        }
                    }
                        
                    else
                    {
                        return
                    }
                }
            }
                
            else
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                Error(error)
            }
            }.resume()
    }
    
    class func postUrl(URL url: String, parameters: [String:Any], Response: @escaping(_ response: [String: Any]) -> Void, statusCode: @escaping(_ statusCode: Int) -> Void, Error: @escaping(_ error: Error?) -> Void, on viewController: UIViewController){
        let HUD = MBProgressHUD()
        
        Constants.printLog(message: parameters);
        
        let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
        
        window=((appDelegate.window)!)
        
        selfView=viewController.view
        selfViewController=viewController
        
        urlString=url
        parametersDictionary=parameters
        
        if Reachability.isConnectedToNetwork(){
            //Constants.printLog(message: "Internet Connection Available!")
        }else{
            Constants.showAlertView(alertViewTitle: "", Message: "Internet Connection not Available!", on: selfViewController)
            
            return
            
            //Constants.printLog(message: "Internet Connection not Available!")
        }
        
        DispatchQueue.main.async {
            HUD.mode=MBProgressHUDMode.indeterminate
            HUD.label.text="Loading"
            HUD.label.textColor = UIColor.darkGray
            
            //MBProgressHUD.showAdded(to: selfView, animated: true)
            
            MBProgressHUD.showAdded(to: window, animated: true)
        }
        
        guard let url1=URL(string: url) else{
            return
        }
        var request=URLRequest(url: url1)
        
        request.httpMethod="POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody=try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
            return
        }
        request.httpBody=httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    statusCode(httpResponse.statusCode)
                    
                    Constants.printLog(message: "url: \(urlString ?? "") \(httpResponse.statusCode)")
                    
                    if httpResponse.statusCode==401
                    {
                        //return
                    }
                        
                    else
                    {
                        if setStatusCode(statusCode: httpResponse.statusCode)==true
                        {
                            let URL_HEROES = "\(Constants.GLOBAL_URL)/patient/register";
                            
                                    if url==URL_HEROES {
                                        Response(["status":"1"])
                                    }
                            
                            guard let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: []) else{
                                DispatchQueue.main.async {
                                    MBProgressHUD.hide(for: window, animated: true)
                                }
                                
                                Error(error)
                                
                                return
                            }
                            
                            if (jsonDict is NSDictionary){
                                Response(jsonDict as! [String: Any])
                            }
                            
                            if (jsonDict is NSArray){
                                print(jsonDict)
                            }
                        }
                            
                        else
                        {
                            DispatchQueue.main.async {
                                statusCode(httpResponse.statusCode)
                            }
                        }
                    }
                }
                
            }
                
            else
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                Error(error)
            }
            }.resume()
    }
    
    class func getURL1(URL url: String, URLResponse: @escaping(_ urlResponse: URLResponse?, _ data: Data?, _ error: Error?) -> Void, on viewController: UIViewController){
        let HUD = MBProgressHUD()
        
        DispatchQueue.main.async {
            HUD.mode=MBProgressHUDMode.indeterminate
            HUD.label.text="Loading"
            HUD.label.textColor = UIColor.darkGray
            
            MBProgressHUD.showAdded(to: viewController.view, animated: true)
        }
        
        
        let url1 = NSURL(string: url)
        
        print(url1 ?? "")
        
        URLSession.shared.dataTask(with: (url1 as URL?)!) { (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: viewController.view, animated: true)
                }
                
                //                guard let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: []) else{
                //                    Error(error)
                //
                //                    return
                //                }
                //
                //                if (jsonDict is NSDictionary){
                //                    Response(jsonDict as! [AnyHashable: Any])
                //                }
                
                URLResponse(response, data, error)
            }
                
            else
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: viewController.view, animated: true)
                }
                
                //Error(error)
            }
            }.resume()
    }
    
    class func postUrl1(URL url: String, parameters: [String:Any], URLResponse: @escaping(_ urlResponse: URLResponse?, _ data: Data?, _ error: Error?) -> Void, on viewController: UIViewController){
        let HUD = MBProgressHUD()
        
        Constants.printLog(message: parameters);
        
        let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
        
        window=((appDelegate.window)!)
        
        selfView=viewController.view
        selfViewController=viewController
        
        urlString=url
        parametersDictionary=parameters
        
        if Reachability.isConnectedToNetwork(){
            //Constants.printLog(message: "Internet Connection Available!")
        }else{
            Constants.showAlertView(alertViewTitle: "", Message: "Internet Connection not Available!", on: selfViewController)
            
            return
            
            //Constants.printLog(message: "Internet Connection not Available!")
        }
        
        DispatchQueue.main.async {
            HUD.mode=MBProgressHUDMode.indeterminate
            HUD.label.text="Loading"
            HUD.label.textColor = UIColor.darkGray
            
            //MBProgressHUD.showAdded(to: selfView, animated: true)
            
            MBProgressHUD.showAdded(to: window, animated: true)
        }
        
        guard let url1=URL(string: url) else{
            return
        }
        var request=URLRequest(url: url1)
        
        request.httpMethod="POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody=try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
            return
        }
        request.httpBody=httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                guard let httpResponse: HTTPURLResponse=response as! HTTPURLResponse else{
                    return
                }
                
                print(httpResponse.statusCode)
                
                guard let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: []) else{
                    //Error(error)
                    
                    return
                }
                
                if (jsonDict is NSDictionary){
                    // Response(jsonDict as! [AnyHashable: Any])
                }
                
                print(jsonDict)
                
                URLResponse(response, data, error)
            }
                
            else
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
            }
            }.resume()
    }
    
    class func postUrl2(URL url: String, parameters: [String:Any], parametersHttp: [String:Any], URLResponse: @escaping(_ urlResponse: URLResponse?, _ data: Data?, _ error: Error?) -> Void, on viewController: UIViewController){
        let HUD = MBProgressHUD()
        Constants.printLog(message: "API: \(url) \n Parameters: \(parameters) Headers: \(parametersHttp)");
        
        let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
        
        //window=((appDelegate.window!))
        
        selfView=viewController.view
        selfViewController=viewController
        
        urlString=url
        parametersDictionary=parameters
        
        if Reachability.isConnectedToNetwork(){
            //Constants.printLog(message: "Internet Connection Available!")
        }else{
            Constants.showAlertView(alertViewTitle: "", Message: "Internet Connection not Available!", on: selfViewController)
            
            return
            //Constants.printLog(message: "Internet Connection not Available!")
        }
        
        DispatchQueue.main.async {
            HUD.mode=MBProgressHUDMode.indeterminate
            HUD.label.text="Loading"
            HUD.label.textColor = UIColor.darkGray
            
            //MBProgressHUD.showAdded(to: selfView, animated: true)
            
            MBProgressHUD.showAdded(to: window, animated: true)
        }
        
        guard let url1=URL(string: url) else{
            return
        }
        var request=URLRequest(url: url1)
        
        request.httpMethod="POST"
        
        if parametersHttp.count>0
        {
            for (key, value) in parametersHttp {
                request.setValue("\(value)", forHTTPHeaderField: "\(key)")
            }
        }
        
         var convertedString = ""
        
        guard let httpBody=try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)else{
            return
        }
        convertedString = String(data: httpBody as Data, encoding: String.Encoding.utf8)!   // the data will be converted to the string
        print(convertedString)
        
        
        request.httpBody=httpBody
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                guard let httpResponse: HTTPURLResponse=response as! HTTPURLResponse else{
                    return
                }
                
                print("Status Code: \(httpResponse.statusCode)")
                
                guard let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: []) else{
                    //Error(error)
                    
                    return
                }
                
                if (jsonDict is NSDictionary){
                    // Response(jsonDict as! [AnyHashable: Any])
                }
                
                print("Response: \(jsonDict)")
                
                URLResponse(response, data, error)
            }
                
            else
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
            }
            }.resume()
    }
    
    
    
    
    class func postUrl3(URL url: String, parameters: [String:Any], parametersHttp: [String:Any], URLResponse: @escaping(_ urlResponse: URLResponse?, _ data: Data?, _ error: Error?) -> Void, on viewController: UIViewController){
        let HUD = MBProgressHUD()
        
        
        Constants.printLog(message: "API: \(url) \n Parameters: \(parameters) Headers: \(parametersHttp)");
        
        let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
        
        window=((appDelegate.window)!)
        
        selfView=viewController.view
        selfViewController=viewController
        
        urlString=url
        parametersDictionary=parameters
        
        if Reachability.isConnectedToNetwork(){
            //Constants.printLog(message: "Internet Connection Available!")
        }else{
            Constants.showAlertView(alertViewTitle: "", Message: "Internet Connection not Available!", on: selfViewController)
            
            return
            
            //Constants.printLog(message: "Internet Connection not Available!")
        }
        
        DispatchQueue.main.async {
            HUD.mode=MBProgressHUDMode.indeterminate
            HUD.label.text="Loading"
            HUD.label.textColor = UIColor.darkGray
            
            //MBProgressHUD.showAdded(to: selfView, animated: true)
            
            MBProgressHUD.showAdded(to: window, animated: true)
        }
        
        guard let url1=URL(string: url) else{
            return
        }
        var request=URLRequest(url: url1)
        
        request.httpMethod="POST"
        
        if parametersHttp.count>0
        {
            for (key, value) in parametersHttp {
                request.setValue("\(value)", forHTTPHeaderField: "\(key)")
            }
        }
        
        var convertedString = ""
        
      //  http://itaag.us-east-1.elasticbeanstalk.com/register/?registrationdetails={ "gender" : "Male", "email" : "rajini1203@gmail.com", "firstName" : "asdasdaadasd",  "lastName" : "dada dad",  "ageGroup" : "80-90"}"
        
      //  parameters = ["gender" : "Male", "email" : "rajini1203@gmail.com", "firstName" : "asdasdaadasd",  "lastName" : "dada dad",  "ageGroup" : "80-90"]
        
        guard let httpBody=try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)else{
            return
        }
        convertedString = String(data: httpBody as Data, encoding: String.Encoding.utf8)!   // the data will be converted to the string
        print(convertedString)
        
        
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
                
                guard let httpResponse: HTTPURLResponse=response as! HTTPURLResponse else{
                    return
                }
                
                print("Status Code: \(httpResponse.statusCode)")
                
                guard let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: []) else{
                    //Error(error)
                    
                    return
                }
                
                if (jsonDict is NSDictionary){
                    // Response(jsonDict as! [AnyHashable: Any])
                }
                
                print("Response: \(jsonDict)")
                
                URLResponse(response, data, error)
            }
                
            else
            {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: window, animated: true)
                }
            }
            }.resume()
    }
    
//    class func refreshTokenService(statusCode1: @escaping(_ statusCode1: Int) -> Void)
//    {
//        //the json file url
//        let URL_HEROES = "\(Constants.GLOBAL_URL)/patient/refresh-signIn";
//
//        //        let userIdDcrpt: String=UserDefaults.standard.value(forKey: "UserId") as! String
//        //        let accessTokenDcrpt: String?=UserDefaults.standard.value(forKey: "access_token") as? String
//        //        let refreshTokenDcrpt: String?=UserDefaults.standard.value(forKey: "refresh_token") as? String
//        //        let deviceTokenDcrpt: String?=UserDefaults.standard.object(forKey: "DeviceToken") as? String
//
//        let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
//
//        let userIdDcrpt: String=appDelegate.userId!
//        let accessTokenDcrpt: String?=appDelegate.accessToken
//        let refreshTokenDcrpt: String?=appDelegate.refreshToken
//        let deviceTokenDcrpt: String?=appDelegate.DeviceToken
//
//        let userId=try! userIdDcrpt.saveAesDecrypt()
//        let accessToken=try! accessTokenDcrpt?.saveAesDecrypt()
//        let refreshToken=try! refreshTokenDcrpt?.saveAesDecrypt()
//        //let deviceToken=try! deviceTokenDcrpt?.saveAesDecrypt()
//
//        URLConnections.postUrl(URL: URL_HEROES, parameters: ["Token": refreshToken ?? "", "UserId": userId, "AccessToken": accessToken ?? "", "DeviceId": deviceTokenDcrpt ?? "", "DeviceType": Constants.Device , "IOSEnvironment": Constants.IOSEnvironment ], Response: { (jsonObj) in
//            var responseDict = jsonObj as Dictionary
//
//            if responseDict.count < 1
//            {
//                //Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
//            }
//
//            else
//            {
//                Constants.printLog(message: responseDict["access_token"] ?? "")
//
//                let accessToken: String="\(responseDict["access_token"] ?? "")"
//                let refreshToken: String="\(responseDict["refresh_token"] ?? "")"
//
//                let accessTokenEncrpt=try! accessToken.saveAesEncrypt()
//                let refreshTokenEncrpt=try! refreshToken.saveAesEncrypt()
//
//                let appDelegate: AppDelegate=UIApplication.shared.delegate as! AppDelegate
//
//                appDelegate.accessToken=accessTokenEncrpt
//                appDelegate.refreshToken=refreshTokenEncrpt
//
//                //                UserDefaults.standard.set(accessTokenEncrpt, forKey: "access_token")
//                //                UserDefaults.standard.set(refreshTokenEncrpt, forKey: "refresh_token")
//                //                UserDefaults.standard.synchronize()
//
//                statusCode1(200)
//
//                //                guard let type: Int = responseDict["AccountId"] as? Int else {
//                //                    Constants.showAlertView(alertViewTitle: "", Message: responseDict["Message"] as! String, on: self)
//                //
//                //                    return
//                //                }
//
//                //printing the json in console
//                //Constants.printLog(message: responseDict)
//            }
//        },statusCode:{(statusCode) in
//            if statusCode==200
//            {
//
//            }
//        }, Error: { (error) in
//            //Constants.showAlertView(alertViewTitle: "", Message: error.debugDescription, on: self)
//        }, on: selfViewController)
//    }
    
    class func setStatusCode(statusCode: Int) -> Bool
    {
        switch statusCode {
        case 200:
            return true
            
        case 403:
            if urlString=="\(Constants.GLOBAL_URL)/patient/authenticate" {
                Constants.showAlertView(alertViewTitle: "Your account locked", Message: "It seems like you have done 5 failed login attempts.Please contact NJHIN Admin for further details.", on: selfViewController)
                
                return false
            }
            
            Constants.showAlertView(alertViewTitle: "", Message: "Forbidden", on: selfViewController)
            
            return false
            
        case 404:
            if urlString=="\(Constants.GLOBAL_URL)/patient/authenticate" {
                Constants.showAlertView(alertViewTitle: "", Message: "Invalid credentials", on: selfViewController)
                
                return false
            }
            
            Constants.showAlertView(alertViewTitle: "", Message: "NotFound", on: selfViewController)
            
            return false
            
        case 500:
            let URL_HEROES = "\(Constants.GLOBAL_URL)/messages/fetch";
            
            if (urlString?.contains(URL_HEROES))! {
                Constants.printLog(message: "Internal Server Error")
                
                
                return false
            }
            
            Constants.showAlertView(alertViewTitle: "", Message: "Internal Server Error", on: selfViewController)
            
            return false
            
        case 400:
            Constants.showAlertView(alertViewTitle: "", Message: "Invalid Use name or Password.", on: selfViewController)
            
            return false
            
        case 409:
            Constants.showAlertView(alertViewTitle: "", Message: "Message is acknowledged by other provider", on: selfViewController)
            
            return false
            
        default:
            Constants.showAlertView(alertViewTitle: "", Message: "\(statusCode)", on: selfViewController)
            
            return false
        }
    }
    
    class func forgotPasswordStausCode(statusCode: Int) -> Bool
    {
        switch statusCode {
        case 200:
            Constants.showAlertView(alertViewTitle: "", Message: "We have sent you an email with instructions to reset your password.", on: selfViewController)
            
            return true
            
        case 206:
            Constants.showAlertView(alertViewTitle: "", Message: "Mail server issue we are unable to send confirmations mails", on: selfViewController)
            
            return false
            
        case 403:
            Constants.showAlertView(alertViewTitle: "", Message: "Account is Locked or in inactive Status.", on: selfViewController)
            
            return false
            
        case 404:
            Constants.showAlertView(alertViewTitle: "", Message: "You have given, Invalid Email.", on: selfViewController)
            
            return false
            
        case 400:
            Constants.showAlertView(alertViewTitle: "", Message: "Error occurred while changing your password.", on: selfViewController)
            
            return false
            
        case 500:
            Constants.showAlertView(alertViewTitle: "", Message: "Problem with Server side code", on: selfViewController)
            
            return false
            
        default:
            Constants.showAlertView(alertViewTitle: "", Message: "\(statusCode)", on: selfViewController)
            
            return false
        }
    }
    
    class func changePasswordStausCode(statusCode: Int) -> Bool
    {
        switch statusCode {
        case 200:
            Constants.showAlertView(alertViewTitle: "", Message: "Your password has been changed successfully.", on: selfViewController)
            
            return true
            
        case 400:
            Constants.showAlertView(alertViewTitle: "", Message: "Error occurred while changing your password.", on: selfViewController)
            
            return false
            
        case 409:
            Constants.showAlertView(alertViewTitle: "", Message: "Do not use most recent password.", on: selfViewController)
            
            return false
            
        case 500:
            Constants.showAlertView(alertViewTitle: "", Message: "Problem with Server side code.", on: selfViewController)
            
            return false
            
        default:
            Constants.showAlertView(alertViewTitle: "", Message: "\(statusCode)", on: selfViewController)
            
            return false
        }
    }
    
//    class func encription(value: String) -> String
//    {
//        let key = "NJHINKEYITON2018" // length == 32
//        let iv = "NJHINKEYITON2018" // length == 16
//        let s = value
//        let enc = try! s.aesEncrypt(key: key, iv: iv)
//
//        //let dec = try! enc.aesDecrypt(key: key, iv: iv)
//        //        Constants.printLog(message: s) // string to encrypt
//        //        Constants.printLog(message: "enc:\(enc)") // 2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
//        //        Constants.printLog(message: "dec:\(dec)") // string to encrypt
//        //        Constants.printLog(message: "\(s == dec)") // true
//
//        return enc
//    }
//
//    class func decription(value: String) -> String
//    {
//        let key = "NJHINKEYITON2018" // length == 32
//        let iv = "NJHINKEYITON2018" // length == 16
//        let s = value
//        //let enc = try! s.aesEncrypt(key: key, iv: iv)
//        let dec = try! s.aesDecrypt(key: key, iv: iv)
//        //        Constants.printLog(message: s) // string to encrypt
//        //        //Constants.printLog(message: "enc:\(enc)") // 2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
//        //        Constants.printLog(message: "dec:\(dec)") // string to encrypt
//        //Constants.printLog(message: "\(s == dec)") // true
//
//        return dec
//    }
    
    public class Reachability {
        
        class func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
            
        }
    }
}
