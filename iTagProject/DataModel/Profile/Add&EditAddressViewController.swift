//
//  Add&EditAddressViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 17/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class Add_EditAddressViewController: UIViewController,DataEnteredDelegate {
    //@IBOutlet weak var addressEDITTableview: UITableView!

    @IBOutlet weak var addeditTableview: UITableView!
    var addressArray = [String]()

//
    var city: String?
    var pincode: String?
    var locality: String?
//    var addressModel: ProfileModelUserAddress?
//    var addressModelArray = [DataEnteredModelSave]()

    var enteredData: DataEnteredModelSave?
//    var addressArray : [String] = [] {
//           didSet {
//               self.addressEDITTableview.reloadData()
//           }
//       }
//
    
//    var addressArray : [String] = [] {
//         didSet {
//             self.addressEDITTableview.reloadData()
//         }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addeditTableview.register(UINib(nibName: "EditAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "EditAddressTableViewCell")
        
        //addressArray.append("\(city ?? "") \(pincode ?? "") \(locality ?? "")")
        
//        pincode = enteredData?.pinCode
//        city = enteredData?.cityField
//        locality = enteredData?.streetField
        print("zoooom valuew \(pincode)")
        addeditTableview.reloadData()
                
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAddressBtn(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileAddressViewController") as! ProfileAddressViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func userDidEnterInformation(info: DataEnteredModelSave) {
        print("map address viewcontroller data \(info)")
                        
    }
}
extension Add_EditAddressViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
                   return 1
               }
        else{
        return addressArray.count//pincode?.count ?? 0//addressModelArray.count//4//userModel?.userAddresses.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let cell: EditAddressTableViewCell = addeditTableview.dequeueReusableCell(withIdentifier: "EditAddressTableViewCell") as! EditAddressTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditAddressTableViewCell", for: indexPath) as! EditAddressTableViewCell

        cell.editButton.addTarget(self, action: #selector(editbuttonClicked(sender:)), for: .touchUpInside)

        if indexPath.section == 0 {
            cell.nameHeader.text = "PrimaryAddress"
            cell.addressLabel.text = KeychainWrapper.standard.string(forKey: "ADDRESS")
        }
        else{
            cell.nameHeader.text = "Other"
            cell.addressLabel.text = addressArray[indexPath.row]//"\(city) \(pincode) \(locality)"
       }
        
        return cell
    }
    
    
    @objc func editbuttonClicked(sender: UIButton) {
        print("in button")
         let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileAddressViewController") as! ProfileAddressViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
}














   

   
