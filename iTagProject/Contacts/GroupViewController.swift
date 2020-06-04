//
//  GroupViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 10/04/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var firstButtonOutlet: UIButton!
    @IBOutlet weak var secondButnOutlet: UIButton!
    @IBOutlet weak var groupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        groupImageView.layer.cornerRadius = groupImageView.frame.height / 2
        groupImageView.layer.masksToBounds = true
        
        groupButton.layer.cornerRadius = groupButton.frame.height / 2
        groupButton.layer.masksToBounds = true
        
        
        firstButtonOutlet.isUserInteractionEnabled = true
        firstButtonOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        
        secondButnOutlet.isUserInteractionEnabled = true
        secondButnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        print("hello")
        
    }
    
    @IBAction func newGroupButn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkMarkBtnAction(_ sender: Any) {
         switch (sender as AnyObject).tag {
         case 1:
             if firstButtonOutlet.currentImage == UIImage(named: "unCheckMark"){
                 firstButtonOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
             } else {
                 firstButtonOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
             }
             break
         case 2:
             if secondButnOutlet.currentImage == UIImage(named: "unCheckMark"){
                 secondButnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
             } else {
                 secondButnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
             }
             break
            default:
            break
        }
    }

}
