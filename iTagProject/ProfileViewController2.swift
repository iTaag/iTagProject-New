//
//  ProfileViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 03/04/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class ProfileViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   @IBAction func backBtnclickAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

