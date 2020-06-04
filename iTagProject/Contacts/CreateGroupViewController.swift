//
//  CreateGroupViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 18/04/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.masksToBounds = true
        
    }
    
    @IBAction func addBUttonAction(_ sender: Any) {
        
        let viewController:GroupViewController=self.storyboard?.instantiateViewController(withIdentifier: "GroupViewController") as! GroupViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
