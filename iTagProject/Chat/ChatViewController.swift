//
//  ViewController.swift
//  KeyboardEx
//
//  Created by iDeveloper2 on 13/03/18.
//  Copyright © 2018 iDeveloper2. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var msgTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
     var chatArray:NSMutableArray=[]

      var itemsArr = ["one", "2", "3", "4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","32","33","34","35","36","37","38","39",]
      override func viewDidLoad() {
          super.viewDidLoad()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

         tableView.register(UINib(nibName: "ReceiverChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverChatTableViewCell")
         tableView.register(UINib(nibName: "ReceiverChatTableViewCell1", bundle: nil), forCellReuseIdentifier: "Cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardNotification(_ notification: Notification) {

        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.customView.superview?.setNeedsLayout()
        //self.customView.superview?.layoutIfNeeded()
    }
        
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                textField.resignFirstResponder()
                return true
            }
        
        override func resignFirstResponder() -> Bool {
            return true
        }
        @IBAction func sendButton(_ sender: UIButton) {
                if sender.tag==1
                {
                let chatStr: String = msgTextField.text!
                chatArray.add("\(chatStr)")
                print("\(chatArray)")
                                
                    chatArray.add("Hi")

                    self.tableView.reloadData()

                        msgTextField.text = ""
                }
                
                else
                {
     
                }
            }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section==0
            {
            return chatArray.count
            }
            
            else
            {
                return 0//1//buttonsArray1.count
            }
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    //
    //        cell.textLabel?.text = itemsArr[indexPath.row]//"hello"
    //
    //        return cell
            
            if (indexPath.row%2)==0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverChatTableViewCell") as? ReceiverChatTableViewCell
                cell?.receiverTextLbl.text = chatArray[indexPath.row] as? String//"hello"
                cell?.receiverTextLbl.textAlignment=NSTextAlignment.right
                
                //set the data here
                return cell!
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ReceiverChatTableViewCell
                //set the data here
                cell?.receiverTextLbl.text=chatArray[indexPath.row] as? String
                cell?.receiverTextLbl.textAlignment=NSTextAlignment.left
                return cell!
            }
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
                if (indexPath.row%2)==0
                {
                    let cell:ReceiverChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReceiverChatTableViewCell") as! ReceiverChatTableViewCell
    
                    let font = UIFont(name: "Helvetica", size: 20.0)
    
                    let height = heightForView(text: cell.receiverTextLbl.text!, font: font!, width: 100.0)
    
                    if height<=50
                    {
                        return UITableView.automaticDimension
                    }
    
                    return 50
                }
            return UITableView.automaticDimension
        }
    
        func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
    
            label.sizeToFit()
    
            return label.frame.height
        }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    

    }


