//
//  DealsViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 19/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//
//
//import UIKit
////import Segmentio
//class DealsViewController: UIViewController {
//
////    @IBOutlet weak var ioView: Segmentio!
////    var content = [SegmentioItem]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//
//
//
//    }
//
//}
//
//  ViewController.swift
//  KeyboardEx
//
//  Created by iDeveloper2 on 13/03/18.
//  Copyright © 2018 iDeveloper2. All rights reserved.
//

import UIKit

class DealsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    // @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
     var itemsArr = ["one", "2", "3", "4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","32","33","34","35","36","37","38","39",]
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "TextField"
//
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden=true
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func handleKeyboardNotification(_ notification: Notification) {
//
//        if let userInfo = notification.userInfo {
//
//            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
//
//            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
//            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
//
//            UIView.animate(withDuration: 0.5, animations: { () -> Void in
//                self.view.layoutIfNeeded()
//            })
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.customView.superview?.setNeedsLayout()
//        //self.customView.superview?.layoutIfNeeded()
//    }
//
//
//         func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            return true
//        }
//
//    override func resignFirstResponder() -> Bool {
//        return true
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = itemsArr[indexPath.row]//"hello"
        
        return cell
    }
    

}
