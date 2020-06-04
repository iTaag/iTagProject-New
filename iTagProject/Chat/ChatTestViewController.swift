//
//  ChatTestViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 23/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class ChatTestViewController: UIViewController {

    @IBOutlet weak var chatBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboard(notification:Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }

        if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
            self.view.frame.origin.y = 272//-keyboardReact.height
        }else{
            self.view.frame.origin.y = 0
        }
    }
}
