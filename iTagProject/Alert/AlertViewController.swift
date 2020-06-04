//
//  AlertViewController.swift
//  LMS
//
//  Created by kranthi on 18/07/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var alertsTableView: UITableView!

   // @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    var employeeArray:NSMutableArray=[]
    var eventsArray:NSMutableArray=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Register the table view cell class and its reuse id
        alertsTableView.register(UINib(nibName: "AlertTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertTableViewCell")
        
        employeeArray=["NagaLaxmi N(F)","Ramya M(F)","Pranavi P(F)","Rajini M(F)","Chandana A(F)","Vasantha P(F)"]
        eventsArray=["Marraige Aniversary","Marraige Aniversary","Birthday","Birthday","Birthday","Marraige Aniversary"]
        
//        backBtn.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
//        backBtn.setTitle("\u{f104}", for: UIControl.State.normal)
//        backBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
//
    }
    
    @IBAction func backBtnClickAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AlertTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell") as! AlertTableViewCell
        
//        cell.nameLbl.text=employeeArray[indexPath.row] as? String
//        cell.eventNameLbl.text=eventsArray[indexPath.row] as? String
        cell.viewButton.tag = indexPath.row
        cell.viewButton.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cell: AlertTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AlertTableViewCell") as! AlertTableViewCell
        //cell.viewButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
        return cell.frame.size.height
    }
    @objc func buttonSelected(sender: UIButton) {
        //let buttonRow = sender.tag
        print("in button")
        
        let viewController:AlertWebPageViewController=self.storyboard?.instantiateViewController(withIdentifier: "AlertWebPageViewController") as! AlertWebPageViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
        

}
