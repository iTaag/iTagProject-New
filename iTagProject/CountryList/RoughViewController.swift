//
//  RoughViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 01/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class RoughViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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




/*
 import UIKit

 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {

     var window: UIWindow?

     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

         let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn") // Give you own check to see if user is logged in

         window = UIWindow()
         window?.makeKeyAndVisible()
         let viewController =  isUserLoggedIn ? MainViewController() : LoginViewController()
         window?.rootViewController = UINavigationController(rootViewController: viewController)

         return true
     }
 }

 class MainViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()

         view.backgroundColor = .green
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleUserLoggedOut))
     }

     @objc func handleUserLoggedOut() {
         UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
         UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoginViewController())
     }
 }

 class LoginViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()

         view.backgroundColor = .red
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(handleUserLoggedIn))
     }

     @objc func handleUserLoggedIn() {
         UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
         UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: MainViewController())
     }
 }
 */




