////
////  ChatViewController.swift
////  iTagProject
////
////  Created by Swapna Botta on 20/03/20.
////  Copyright © 2020 iTag. All rights reserved.
////
//
//import UIKit
//
//class ChatViewController: UIViewController, UITextFieldDelegate {
//
//    //@IBOutlet weak var belowtextFieldHeightConstraint: NSLayoutConstraint!
//
//   // @IBOutlet weak var catViewBottomConstraint: NSLayoutConstraint!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//               NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//               NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//            }
//
//    @objc func keyboard(notification:Notification) {
//        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
//            return
//        }
//
//        if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
//            self.view.frame.origin.y = -keyboardReact.height
//        }else{
//            self.view.frame.origin.y = 0
//        }
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//    @IBAction func backButton(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//
//
//}

//
//  ChatViewController.swift
//  Pop-up Clinic
//
//  Created by kranthi on 23/01/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

import AVFoundation

class ChatViewController1: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
  
    @IBOutlet weak var chatUseName: UILabel!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var chatArray:NSMutableArray=[]
    
    var userName:String!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var buttonsArray: NSMutableArray=[]
    var answerArray: NSMutableArray=[]
    var buttonsArray1: NSMutableArray=[]
    var answerArray1: NSMutableArray=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Register the table view cell class and its reuse id
        chatTableView.register(UINib(nibName: "ReceiverChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverChatTableViewCell")
        chatTableView.register(UINib(nibName: "ReceiverChatTableViewCell1", bundle: nil), forCellReuseIdentifier: "Cell")
        //chatTableView.register(UINib(nibName: "ReceiverChatTableViewCell2", bundle: nil), forCellReuseIdentifier: "Cell1")
        
        //self.navigationBarButton()
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

//    func navigationBarButton() {
//        backButton.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
//        backButton.setTitle(" \u{f104}", for: UIControl.State.normal)
//        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
//        //backButton.addTarget(self, action: #selector(self.backButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
//    }
    
    @IBAction func backBtnclickAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backButton(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        @objc func keyboard(notification:Notification) {
            guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
                return
            }
    
            if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
                self.view.frame.origin.y = -keyboardReact.height
            }else{
                self.view.frame.origin.y = 0
            }
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
    // number of rows in table view
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
            return buttonsArray1.count
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        if indexPath.section==0
        {
        if (indexPath.row%2)==0
        {
        let cell:ReceiverChatTableViewCell = (chatTableView.dequeueReusableCell(withIdentifier: "ReceiverChatTableViewCell") as! ReceiverChatTableViewCell?)!
        
        cell.chatView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        cell.chatView.layer.cornerRadius=cell.chatView.frame.size.height/2
        
        cell.receiverTextLbl.text=chatArray[indexPath.row] as? String
        cell.receiverTextLbl.textAlignment=NSTextAlignment.right
        
        let font = UIFont(name: "Helvetica", size: 20.0)
        
        //var height = heightForView(text: cell.receiverTextLbl.text!, font: font!, width: 100.0)
        
        
      return cell
        }
        
        else
        {
            let cell:ReceiverChatTableViewCell = (chatTableView.dequeueReusableCell(withIdentifier: "Cell") as! ReceiverChatTableViewCell?)!
            
            cell.chatView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
            cell.chatView.layer.cornerRadius=cell.chatView.frame.size.height/2
            
            cell.receiverTextLbl.text=chatArray[indexPath.row] as? String
            cell.receiverTextLbl.textAlignment=NSTextAlignment.left
            
            let font = UIFont(name: "Helvetica", size: 20.0)
            
            var height = heightForView(text: cell.receiverTextLbl.text!, font: font!, width: 100.0)
            
            return cell
        }
        }
        
        else
        {
            let cell:ReceiverChatTableViewCell = (chatTableView.dequeueReusableCell(withIdentifier: "Cell1") as! ReceiverChatTableViewCell?)!

            cell.receiverTextLbl.text=buttonsArray1[indexPath.row] as? String

            let font = UIFont(name: "Helvetica", size: 20.0)

            var height = heightForView(text: cell.receiverTextLbl.text!, font: font!, width: 100.0)

            let indexPath1: IndexPath=IndexPath(item: indexPath.last!, section: 1)

                    tableView.scrollToRow(at: indexPath1, at: .bottom, animated: true)

            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section==0 {
            
        }
        
        else
        {
            chatArray.add(buttonsArray1[indexPath.row])
            chatArray.add(answerArray1[indexPath.row])
            
            let title: NSString=buttonsArray1[indexPath.row] as! NSString
            
            buttonsArray1=[]
            answerArray1=[]
            
            if title=="My Account" || title=="New Document" || title=="Add Document" || title=="Single Provider" || title=="Muiltiple Providers" || title=="Add Care Team"
            {
                buttonsArray1.add("Help")
                answerArray1.add("For more Information about account contact: 1234567892")
            }
            
            else if title=="Help"
            {
                answerArray1.add("For more Information about account contact: 1234567892")
            }
            
            else if title=="Upload Document"
            {
                buttonsArray1.add("New Document")
                buttonsArray1.add("Add Document")
                answerArray1.add("In dashboard you can see upload button from there ypu can upload documents.")
                answerArray1.add("Click on exist appointment add document.")
            }
            
            else if title=="Upload Document"
            {
                buttonsArray1.add("New Document")
                buttonsArray1.add("Add Document")
                answerArray1.add("In dashboard you can see upload button from there ypu can upload documents.")
                answerArray1.add("Click on exist appointment add document.")
            }
            
            else if title=="Share Document"
            {
                buttonsArray1.add("Single Provider")
                buttonsArray1.add("Muiltiple Providers")
                answerArray1.add("You can share document with single provider by selecting provider from share screen.")
                answerArray1.add("You can share document with mulitiple providers by selecting provider from share screen.")
            }
            
            tableView.reloadData()
        }
        
//        let indexPath1: IndexPath=IndexPath(item: buttonsArray1.count-1, section: 1)
//
//        tableView.scrollToRow(at: indexPath1, at: .bottom, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
            if (indexPath.row%2)==0
            {
                let cell:ReceiverChatTableViewCell = (chatTableView.dequeueReusableCell(withIdentifier: "ReceiverChatTableViewCell") as! ReceiverChatTableViewCell?)!
                
                let font = UIFont(name: "Helvetica", size: 20.0)
                
                var height = heightForView(text: cell.receiverTextLbl.text!, font: font!, width: 100.0)
                
                if height<60
                {
                    height=60
                }
                return height
            }
            
//            else
//            {
//        let cell:ReceiverChatTableViewCell = (chatTableView.dequeueReusableCell(withIdentifier: "Cell1") as! ReceiverChatTableViewCell?)!
//
//        let font = UIFont(name: "Helvetica", size: 20.0)
//
//        var height = heightForView(text: cell.receiverTextLbl.text!, font: font!, width: 100.0)
//
//        if height<100
//        {
//            height=100
//        }
//
//          return height
//        }
    }
            
        else
        {
            return 50
        }
        return UITableView.automaticDimension
    }
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 1000
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        
        return label.frame.height
    }
    @IBAction func sendBtnClickAction(_ sender: UIButton) {
        if sender.tag==1
        {
        let chatStr:String=chatTextField.text!
        chatArray.add("\(chatStr)")
        print("\(chatArray)")
        
//                let request = ApiAI.shared().textRequest()
//
//                if let text = self.chatTextField.text, text != "" {
//                    request?.query = text
//
//                    chatArray.add("\(text)")
//
//                    chatTableView.reloadData()
//
//                } else {
//                    return
//                }
//
//                request?.setMappedCompletionBlockSuccess({ (request, response) in
//                    let response = response as! AIResponse
//                    if let textResponse = response.result.fulfillment.speech {
//                        self.speechAndText(text: textResponse)
//                    }
//                }, failure: { (request, error) in
//                    print(error!)
//                })
//
//                ApiAI.shared().enqueue(request)
            
            chatArray.add("Hi")

            self.chatTableView.reloadData()

                chatTextField.text = ""
        }
        
        else
        {
//            buttonsArray1=[]
//            answerArray1=[]
//
//            buttonsArray1.addObjects(from: buttonsArray as! [Any])
//            answerArray1.addObjects(from: answerArray as! [Any])
//
//            self.chatTableView.reloadData()
        }
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
    
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.chatArray.add("\(text)")
            
            self.chatTableView.reloadData()
        }, completion: nil)
    }
}

