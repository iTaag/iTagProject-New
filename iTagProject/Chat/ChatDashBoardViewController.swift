//
//  ChatDashBoardViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 30/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class ChatDashBoardViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var chatButn: UIButton!
        var employeeArray:NSMutableArray = []
           var holidayList:NSMutableArray   = []
           
           override func viewDidLoad() {
               super.viewDidLoad()

            // Do any additional setup after loading the view.
            chatButn.layer.cornerRadius = chatButn.frame.height / 2
            chatButn.layer.shadowOffset = CGSize(width: 0, height: 1)
            chatButn.layer.shadowColor = UIColor.lightGray.cgColor
            chatButn.layer.shadowOpacity = 1
            chatButn.layer.shadowRadius = 5
            chatButn.layer.masksToBounds = false
               
            //Register the table view cell class and its reuse id
            chatTableView.register(UINib(nibName: "ChatDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatDashboardTableViewCell")
               employeeArray = ["Sachin","Dhoni","Kohli","Dravid","Youraj"," Raina","India"]
               holidayList   = ["Not Applicable","Not Applicable","Not Applicable","Not Applicable","Not Applicable","Not Applicable", "Not Applicable"]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return employeeArray.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell: ChatDashboardTableViewCell = chatTableView.dequeueReusableCell(withIdentifier: "ChatDashboardTableViewCell") as! ChatDashboardTableViewCell
           cell.NameLbl.text   = employeeArray[indexPath.row] as? String
           cell.StatusLbl.text = holidayList [indexPath.row]   as? String
        
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            
//            cell.personImageContainer.layer.cornerRadius = 30//cell.personImageContainer.frame.width / 2
//            cell.personImageContainer.clipsToBounds = true
            
            cell.personImage.layer.cornerRadius = 30//cell.personImageContainer.frame.width / 2
            cell.personImage.clipsToBounds = true

        }
           return cell
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let viewController: ChatViewController=self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
           
           self.navigationController?.pushViewController(viewController, animated: true)
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           let cell: ChatDashboardTableViewCell = chatTableView.dequeueReusableCell(withIdentifier: "ChatDashboardTableViewCell") as! ChatDashboardTableViewCell
           if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                  return 100
              }
              else {
                  return cell.frame.size.height
              }
           return cell.frame.size.height
       }
    
    @IBAction func chatBtnClicked(_ sender: Any) {
        let viewController: ChatViewController=self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
