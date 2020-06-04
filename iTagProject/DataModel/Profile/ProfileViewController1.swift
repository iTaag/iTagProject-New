//
//  ProfileViewController1.swift
//  Blockchain
//
//  Created by admin on 15/11/18.
//  Copyright © 2018 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import DropDown
import SwiftKeychainWrapper
class ProfileViewController1: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var editImgeBtn: UIButton!
    @IBOutlet weak var mobileTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
   
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var matirialStatus: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var dobIconLabel: UILabel!
    @IBOutlet weak var ssnIconLabel: UILabel!
    @IBOutlet weak var phoneIconLabel: UILabel!
    @IBOutlet weak var emailIconLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var bgColorView: GRView!
    @IBOutlet weak var subBgColorView: GRView!
    @IBOutlet weak var subColorBgView1: GRView!
    @IBOutlet weak var subBgColorView3: GRView!
    @IBOutlet weak var subBgColorView4: GRView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var ssnBgView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var datePicker=UIDatePicker()
    
    let genderDropDown = DropDown()
    let maritalStatusDropDown = DropDown()
    
    var imageUrl: String?
    
    var appDelgate = UIApplication.shared.delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        appDelgate = UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dobIconLabel?.font=UIFont(name: "fontawesome", size: 20)
        dobIconLabel?.text=" \u{f073}"
        dobIconLabel?.textColor=UIColor.white
        
        phoneIconLabel?.font=UIFont(name: "fontawesome", size: 20)
        phoneIconLabel?.text=" \u{f10b}"
        phoneIconLabel?.textColor=UIColor.white
        
        emailIconLabel?.font=UIFont(name: "fontawesome", size: 20)
        emailIconLabel?.text=" \u{f0e0}"
        emailIconLabel?.textColor=UIColor.white
        
        saveBtn.titleLabel?.font=UIFont(name: "fontawesome", size: 25)
        saveBtn.setTitle(" \u{f040}", for: UIControl.State.normal)
        saveBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        editImgeBtn.titleLabel?.font=UIFont(name: "fontawesome", size: 15)
        editImgeBtn.setTitle(" \u{f040}", for: UIControl.State.normal)
        editImgeBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        editProfile()
        let imageName = "AppIcon"
        guard let image = UIImage(named: imageName) else { return  }
        
        editProfile(paramName: "profileImage", image: image)
        
        let dateFormater=DateFormatter()
        
        dateFormater.dateFormat="MM-dd-yyyy"
        
        let date2=dateFormater.string(from: Date())
        
        dobTF.text=date2
        
        self.setTextFieldEditing(enable: false)
        
        self.setDropDown()
        self.setdatePicker()
        
        if genderTF.text=="M" {
            genderTF.text="Male"
        }
        
        else
        {
            genderTF.text="Female"
        }
        
        if matirialStatus.text=="M" {
            matirialStatus.text="Married"
        }
        
        else
        {
            matirialStatus.text="Unmarried"
        }
        
        self.navigationBarButton()
        
        //editUserProfile()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
        //self.navigationController?.navigationBar.isTranslucent=true
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
   
    
//    func editProfile() {
//        let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
//
//        let headers = ["deviceid": "EC3746E9-4DB4-42C7-9D8C-1542B18C2AC","userType": "personal","key": "5fe42fb3b54543a0bab5667cf96526f8" ]
//        let parameters: [String: Any] = ["firstName":"Satish", "lastName":"Madhavarapu","gender":"male", "ageGroup":"40-50"]
//        //UserDefaults.standard.set(self.emailTextField.text!, forKey: "RegEmail")
//
//        let URL_HEROES = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/editprofile/"
//        let url = URL (string: URL_HEROES)
//        var _ : NSError?
//        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//        print(jsonString)
//        var request = URLRequest(url: url!)
//        //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")  // the request is JSON
//
//        request.httpMethod = "POST"
//        //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        let postData = String(format: "profiledetails=%@",jsonString) .data(using: .utf8)
//        request.httpBody = postData
//        request.allHTTPHeaderFields = headers
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error!)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse! as Any)
//
//                if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
//                    print("editprofile json \(jsonObj)")
//                }
//            }
//        })
//        dataTask.resume()
//    }
    
    
    func editProfile(paramName: String, image: UIImage) {
        
        let headers = ["deviceid": "EC3746E9-4DB4-42C7-9D8C-1542B18C2AC","userType": "personal","key": "5fe42fb3b54543a0bab5667cf96526f8" ]
        let parameters: [String: Any] = ["firstName":"Satish", "lastName":"Madhavarapu","gender":"male", "ageGroup":"40-50"]
        
         let URL_HEROES = Constants.GLOBAL_URL + "/editprofile/"
         let url = URL (string: URL_HEROES)
        
          var _ : NSError?
                let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
                print(jsonString)
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
        
                let postData = String(format: "profiledetails=%@",jsonString) .data(using: .utf8)
                request.httpBody = postData
                request.allHTTPHeaderFields = headers
                let session = URLSession.shared
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\("profileImage")\"; \r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        profileImage.image = image
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        session.uploadTask(with: request, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print("json edit \(json)")
                }
            }
        }).resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func imageCapatureBtnClickAction(_ sender: UIButton) {
        
        self.addButtonClicked(sender)
    }
    
    @IBAction func saveBtnClickAction(_ sender: UIButton) {
        if sender.tag==1
        {
            if sender.isSelected==false
            {
                saveBtn.setTitle(" \u{f0c7}", for: UIControl.State.normal)
                saveBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                
                self.setTextFieldEditing(enable: true)
                
                sender.isSelected=true
            }
            
            else
            {
                saveBtn.setTitle(" \u{f040}", for: UIControl.State.normal)
                saveBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
                
                self.setTextFieldEditing(enable: false)
                
                sender.isSelected=false
            }
        }
        
        else
        {
            if saveBtn.titleLabel?.text==" \u{f0c7}"
            {
                
            }
        }
    }
    
    func validation() -> Bool
    {
        if (firstName.text?.count)!<1 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Enter First Name", on: self)
            
            return false
        }
        else if (lastNameTF.text?.count)!<1 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Last Name", on: self)
            
            return false
        }
            
        else if (dobTF.text?.count)!<1 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Select Date of Birth", on: self)
            
            return false
        }
            
                            else if (genderTF.text?.count)!<1 {
                                Constants.showAlertView(alertViewTitle: "", Message: "Please Select Gender", on: self)
            
                                return false
                            }
            
        else if (emailTF.text?.count)!<1 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Email", on: self)
            
            return false
        }
            
                            else if (phoneLabel.text?.count)!<1 {
                                Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Phone Number", on: self)
            
                                return false
                            }
            
        else if (phoneLabel.text?.count)! != 10 && (phoneLabel.text?.count)!>0 {
            Constants.showAlertView(alertViewTitle: "", Message: "Please Enter Valid Phone Number", on: self)
            
            return false
        }
        
        return true
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
    @IBAction func dropDownButtonClicked(_ sender: UIButton) {
        if saveBtn.titleLabel?.text==" \u{f0c7}"
        {
        switch sender.tag {
        case 3:
            genderDropDown.show()
            break
            
        case 2:
            maritalStatusDropDown.show()
            break
            
        default:
            genderDropDown.show()
            break
        }
        }
    }
    
    func setDropDown()
    {
        genderDropDown.anchorView=genderTF
        //leaveTypeDropDown.width=200
        genderDropDown.direction = .any
        genderDropDown.bottomOffset=CGPoint(x: 0, y: genderTF.bounds.height)
        genderDropDown.dataSource=["Male", "Female"]
        
        maritalStatusDropDown.anchorView=matirialStatus
        //leaveTypeDropDown.width=200
        maritalStatusDropDown.direction = .any
        maritalStatusDropDown.bottomOffset=CGPoint(x: 0, y: matirialStatus.bounds.height)
        maritalStatusDropDown.dataSource=["Married", "Unmarried"]
        
        genderDropDown.selectionAction = {(index, item) in
            self.genderTF.text=item
        }
        
        maritalStatusDropDown.selectionAction = {(index, item) in
            self.matirialStatus.text=item
        }
    }
    
    func setdatePicker()
    {
        datePicker.datePickerMode=UIDatePicker.Mode.date
        
        let toolBar=UIToolbar()
        
        toolBar.sizeToFit()
        
        let doneButton=UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonClicked))
        let spaceButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton=UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelButtonClicked))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        
        dobTF.inputAccessoryView=toolBar
        dobTF.inputView=datePicker
    }
    
    @objc func doneButtonClicked()
    {
        self.view.endEditing(true)
        
        let date=Date()
        
        let dateFormat=DateFormatter()
        
        dateFormat.dateFormat="MM-dd-yyyy"
        
        let date1=dateFormat.string(from: datePicker.date)
        
        dobTF.text=date1
    }
    
    @objc func cancelButtonClicked()
    {
        self.view.endEditing(true)
    }
    
    func addButtonClicked(_ sender: UIButton) {
        let alertController: UIAlertController = UIAlertController(title: "Select", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert) in
            self.setGallery()
        }))
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.setTakeImage()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (alert) in
            
        }))
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func setGallery()
    {
        let imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=true
        imagePicker.sourceType=UIImagePickerController.SourceType.savedPhotosAlbum
        imagePicker.delegate=self
        
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func setTakeImage()
    {
        let imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=true
        imagePicker.sourceType=UIImagePickerController.SourceType.camera
        imagePicker.delegate=self
        
        self.navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        let image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]
        
        profileImage.image=image as! UIImage
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func setTextFieldEditing(enable: Bool)
    {
        firstName.isEnabled=enable
        lastNameTF.isEnabled=enable
        mobileTF.isEnabled=enable
        genderTF.isEnabled=enable
        dobTF.isEnabled=enable
        saveButton.isEnabled=enable
        
        firstName.isUserInteractionEnabled=enable
        lastNameTF.isUserInteractionEnabled=enable
        mobileTF.isUserInteractionEnabled=enable
        genderTF.isUserInteractionEnabled=enable
        dobTF.isUserInteractionEnabled=enable
        saveButton.isUserInteractionEnabled=enable
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
