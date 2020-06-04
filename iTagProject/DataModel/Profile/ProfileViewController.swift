//
//  ProfileViewController.swift
//  LMS
//
//  Created by admin on 1/3/18.
//  Copyright © 2018 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class ProfileViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var addressTableview: UITableView!
    @IBOutlet var profileHeader: UIImageView!
    
    var newImage: UIImage!
    var editFirstName: String?
    var editLastName: String?

    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var number: UILabel!
    var userModel : ProfileModel? 
    
    var addressArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationBarButton()
        profileHeader.image = newImage
        userModel?.profileImageUrl = profileHeader.image as? String
        userModel?.firstName = editFirstName
        userModel?.lastName = editLastName
        addressTableview.register(UINib(nibName: "AddresCell", bundle: nil), forCellReuseIdentifier: "AddresCell")
        addressTableview.reloadData()
        getUserProfile()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func navigationBarButton() {
        backButton.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
        backButton.setTitle(" \u{f104}", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(self.backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
    }
    @objc func backButtonClicked(sender:UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    @IBAction func goToContacts() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactsDashboardViewController") as! ContactsDashboardViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    @IBAction func goToEditBtn(_ sender: Any) {
        
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController1") as! ProfileViewController1
//        self.navigationController?.pushViewController(viewController, animated: true)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func securityBtn(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecurityViewController") as! SecurityViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func addandEditAddressBtn(_ sender: Any) {
       let viewController = storyboard?.instantiateViewController(withIdentifier: "Add_EditAddressViewController") as! Add_EditAddressViewController
        viewController.addressArray = addressArray


        print("total address array all rows \(viewController.addressArray)")
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AppSettingsViewController") as! AppSettingsViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func getUserProfile() {
        //let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

        let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""

        //let personalId: String = UserDefaults.standard.string(forKey: "USERID") ?? ""
        let headers = ["deviceid": deviceId,"userType": "personal","key": personalId]
//        let urlStr  = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/getprofile/?requestedUserType=" + "personal&requestedKey=" + personalId

        let string = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/getprofile/"
        var urlComponents = URLComponents(string: string)
        let requestedUserType = URLQueryItem(name: "requestedUserType", value: "personal")

        let requestedItem = URLQueryItem(name: "requestedKey", value: personalId)
        urlComponents?.queryItems = [requestedItem, requestedUserType]
        let urlStr = urlComponents?.url
        
        let request = NSMutableURLRequest(url: urlStr!, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers as! [String : String]
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse!.statusCode == 200 {
                    do {
                        let jsonObject  = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String :AnyObject]
                        self.userModel = ProfileModel.init(fromDictionary: jsonObject)
                        print("profile json \(jsonObject)")
                        print("profile personalid 2222 \(self.userModel?.userId)")

                        if (self.userModel?.userId) != nil {
                            DispatchQueue.main.async {
                                self.updateUserDetails()
                                self.addressTableview.reloadData()
                            }
                        } else { DispatchQueue.main.async { Constants.showAlertView(alertViewTitle: "", Message: "No user data found", on: self)}}
                    } catch { print(error.localizedDescription) }
                } else {
                    //Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again", on: self)
                    
                }
            }
        })
        dataTask.resume()
    }
    func updateUserDetails() {
        name.text = userModel?.firstName
        number.text = userModel?.phone
       profileHeader.image =  userModel?.profileImageUrl as? UIImage

        //KeychainWrapper.standard.set(userModel?.email ?? "", forKey: "RegEmail")

        //print("NSObject model name from Registration \(savedEmail)")
//        if let imageStr = userModel?.profileImageUrl {
//            let imageUrl = URL(string: imageStr)
//            profileHeader.sd_setImage(with: imageUrl, placeholderImage:UIImage(named: "3"), options:.refreshCached) {(image, error, cacheType, url) in
//                if error == nil { self.profileHeader.image = image }
//            }
//            profileImg.sd_setImage(with: imageUrl, placeholderImage:UIImage(named: "3"), options:.refreshCached) {(image, error, cacheType, url) in
//                if error == nil { self.profileImg.image = image }
//            }
//        }
    }
}
extension ProfileViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
                   return userModel?.userAddresses.count ?? 0
               }
        else{
            return addressArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AddresCell = tableView.dequeueReusableCell(withIdentifier: "AddresCell") as! AddresCell
       
         if indexPath.section == 0 {
            let addr = userModel?.userAddresses![indexPath.row]
                    cell.name.text    = addr?.addressName
                  let street = addr?.streetName
                  let colony = addr?.colony
                  let city   = addr?.city
                   let pincode = addr?.pincode
                    cell.address.text = street! + "," + colony! + "," + city! + "," + pincode!
                    KeychainWrapper.standard.set(cell.address.text ?? "", forKey: "ADDRESS")
         }
         else{
             cell.address.text = "Other"

            cell.address.text = addressArray[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
}
