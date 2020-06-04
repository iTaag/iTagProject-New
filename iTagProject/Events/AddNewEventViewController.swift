//
//  AddNewEventViewController.swift
//  iTag
//
//  Created by Processweaver on 16/09/2562 BE.
//  Copyright © 2562 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
//import Alamofire
import UserNotifications
import AVFoundation
import Photos

class AddNewEventViewController: UIViewController, UIPickerViewDelegate,UIImagePickerControllerDelegate, UIPickerViewDataSource,UINavigationControllerDelegate {
    
    @IBOutlet weak var imgPick: UIImageView!
    @IBOutlet var eventNameField: FloatingTextField!
    @IBOutlet var locationField: FloatingTextField!
    @IBOutlet var allDayButton: UIButton!
    @IBOutlet var fromDateButton: UIButton!
    @IBOutlet var toDateButton: UIButton!
    @IBOutlet var repeatNeverButton: UIButton!
    @IBOutlet var repeatDropDownButton: UIButton!
    @IBOutlet var messageField: FloatingTextField!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet weak var addAllImageView: UIImageView!
    
    @IBOutlet var fromDateLabel: UILabel!
    @IBOutlet var toDateLabel: UILabel!
    @IBOutlet weak var occuranceLabel: UILabel!
    @IBOutlet weak var repeatsLabel: UILabel!
    @IBOutlet var dtPicker: UIDatePicker!
    @IBOutlet weak var occurancePickerView: UIPickerView!
    @IBOutlet var datePickerBaseView: UIView!
    @IBOutlet var continueView: UIView!
    @IBOutlet var textFieldsBaseView: UIView!
    @IBOutlet weak var toDateBaseView: UIView!
    @IBOutlet weak var occuranceBaseView: UIView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var stackBaseViewHeightConstraint: NSLayoutConstraint!
    
    var pickerBool:Bool = false
    @IBOutlet weak var twoDaysBeforeLabel: UILabel!
    @IBOutlet weak var threeHoursBeforeLabel: UILabel!
    @IBOutlet weak var oneHourBeforeLabel: UILabel!
    @IBOutlet weak var oneDayBeforeLabel: UILabel!
    @IBOutlet weak var fiveMinsBeforeLabel: UILabel!
    @IBOutlet weak var fifteenMinsBeforeLabel: UILabel!
    
    @IBOutlet weak var twoDaysBtnOutlet: UIButton!
    @IBOutlet weak var oneDayBtnOutlet: UIButton!
    @IBOutlet weak var threeHrsBtnOutlet: UIButton!
    @IBOutlet weak var oneHrsBtnOutlet: UIButton!
    @IBOutlet weak var fifteenMinsBtnOutlet: UIButton!
    @IBOutlet weak var fiveMinsBtnOutlet: UIButton!
    @IBOutlet weak var guestListBtnOutlet: UIButton!
    @IBOutlet weak var groupBtnOutlet: UIButton!
    @IBOutlet weak var taggedBtnOutlet: UIButton!
    
    var allBtnClicked  = "false"
    var occuranceFieldShow:Bool = false
    var occurancePickerData: [String] = [String]()
    var eventStartDate:Date!
    var picker = UIImagePickerController()
    var pickedImage = UIImage(named: "images123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBarButton()
        self.navigationController?.navigationBar.isHidden = true
        hideKeyboardWhenTappedAround()
        stackBaseViewHeightConstraint.constant = 350
        occuranceBaseView.isHidden = true
        picker.delegate = self
        picker.allowsEditing = true
        occurancePickerData = ["0","1", "2", "3", "4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30",]
    }
    
    func navigationBarButton() {
        menuButton.titleLabel?.font = UIFont(name: "fontawesome", size: 25)
        menuButton.setTitle(" \u{f104}", for: UIControl.State.normal)
        menuButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        menuButton.addTarget(self, action: #selector(backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
    }
    @objc func backButtonClicked(sender:UIButton) {
       /* if continueView.isDescendant(of: view) {
            resetReminderView()
            continueView.removeFromSuperview()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
 */
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func fromDateBtnAction(_ sender: Any) {
        pickerBool = true
        occurancePickerView.isHidden = true
        dtPicker.isHidden = false
        showDatePickerBaseView()
    }
    @IBAction func toDateBtnAction(_ sender: Any) {
        pickerBool = false
        occurancePickerView.isHidden = true
        dtPicker.isHidden = false
        showDatePickerBaseView()
    }
    @IBAction func allDayBtnAction(_ sender: Any) {
        
        if allBtnClicked == "false" {
            allBtnClicked = "true"
            toDateBaseView.isHidden = true
            self.showOccuranceFields()
            fromDateLabel.text = "Event Date"
            addAllImageView.image = UIImage(named: "checkMark")
        } else {
            allBtnClicked = "false"
            toDateBaseView.isHidden = false
            self.showOccuranceFields()
            fromDateLabel.text = "From Date"
            addAllImageView.image = UIImage(named: "unCheckMark")
        }
    }
    
    @IBAction func repeatsBtnAction(_ sender: Any) {
        movePickerToDown()
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let repeatAction: UIAlertAction = UIAlertAction(title: "Repeat", style: .default) { action -> Void in
            //Code for launching the camera goes here
            self.repeatsLabel.text = "Repeat"
            self.occuranceFieldShow = false
            self.showOccuranceFields()
        }
        actionSheetController.addAction(repeatAction)
        //Create and add a second option action
        let neverAction: UIAlertAction = UIAlertAction(title: "Never", style: .default) { action -> Void in
            //Code for picking from Gallery  goes herece
            self.repeatsLabel.text = "Never"
            self.occuranceFieldShow = false
            self.showOccuranceFields()
        }
        actionSheetController.addAction(neverAction)
        //Create and add a third option action
        let dailyAction: UIAlertAction = UIAlertAction(title: "Daily", style: .default) { action -> Void in
            //Code for picking from Gallery  goes herece
            self.repeatsLabel.text = "Daily"
            self.occuranceFieldShow = true
            self.showOccuranceFields()
        }
        actionSheetController.addAction(dailyAction)
        //Create and add a forth option action
        let weeklyAction: UIAlertAction = UIAlertAction(title: "Weekly", style: .default) { action -> Void in
            //Code for picking from Gallery  goes herece
            self.repeatsLabel.text = "Weekly"
            self.occuranceFieldShow = true
            self.showOccuranceFields()
        }
        actionSheetController.addAction(weeklyAction)
        //Create and add a fifth option action
        let monthlyAction: UIAlertAction = UIAlertAction(title: "Monthly", style: .default) { action -> Void in
            //Code for picking from Gallery  goes herece
            self.repeatsLabel.text = "Monthly"
            self.occuranceFieldShow = true
            self.showOccuranceFields()
        }
        actionSheetController.addAction(monthlyAction)
        //Create and add a sixth option action
        let annuallyAction: UIAlertAction = UIAlertAction(title: "Annually", style: .default) { action -> Void in
            //Code for picking from Gallery  goes herece
            self.repeatsLabel.text = "Annually"
            self.occuranceFieldShow = true
            self.showOccuranceFields()
        }
        actionSheetController.addAction(annuallyAction)
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func showOccuranceFields() -> () {
        if self.occuranceFieldShow == false {
            self.occuranceBaseView.isHidden = true
            if allBtnClicked == "false" {
                stackBaseViewHeightConstraint.constant = 350
            } else {
                stackBaseViewHeightConstraint.constant = 300
            }
        } else {
            self.occuranceBaseView.isHidden = false
            if allBtnClicked == "false" {
                stackBaseViewHeightConstraint.constant = 400
            } else {
                stackBaseViewHeightConstraint.constant = 350
            }
        }
    }
    
    @IBAction func occuranceBtnAction(_ sender: Any) {
        occurancePickerView.isHidden = false
        dtPicker.isHidden = true
        showDatePickerBaseView()
    }
    
    func timeIntervalBetweenCurrentDateAndEventDate() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([ .second])
        let datecomponenets = calendar.dateComponents(unitFlags, from: currentDate, to: eventStartDate)
        let seconds = datecomponenets.second
        print("Seconds: \(String(describing: seconds))")
        return seconds ?? 0
    }
    
    func showDatePickerBaseView() {
        let size = UIScreen.main.bounds
        self.datePickerBaseView.frame = CGRect(x:0, y: size.height, width: size.width, height:220)
        self.datePickerBaseView.alpha = 1.0
        self.view.addSubview(self.datePickerBaseView)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.datePickerBaseView.frame.origin.y = size.height - 220
        }, completion: {(isCompleted) in
        })
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        
        let dateFormatter       = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: dtPicker.date)
        eventStartDate = dtPicker.date
        if pickerBool == true {
            fromDateLabel.text = strDate
        } else {
            toDateLabel.text = strDate
        }
    }
    @IBAction func doneBtnAction(_ sender: Any) {
        
        movePickerToDown()
    }
    func movePickerToDown() -> () {
        
        UIView.animate(withDuration: 1.0, delay: 0.3, options: .curveEaseOut, animations: {
            let size = UIScreen.main.bounds
            self.datePickerBaseView.frame.origin.y = size.height + 220
        }, completion: {(isCompleted) in
        })
    }
    func resetReminderView() {
        twoDaysBeforeLabel.textColor = UIColor.lightGray
        oneDayBeforeLabel.textColor  = UIColor.lightGray
        threeHoursBeforeLabel.textColor = UIColor.lightGray
        oneHourBeforeLabel.textColor    = UIColor.lightGray
        fifteenMinsBeforeLabel.textColor = UIColor.lightGray
        fiveMinsBeforeLabel.textColor    = UIColor.lightGray
        
        twoDaysBtnOutlet.isUserInteractionEnabled = true
        oneDayBtnOutlet.isUserInteractionEnabled = true
        threeHrsBtnOutlet.isUserInteractionEnabled = true
        oneHrsBtnOutlet.isUserInteractionEnabled = true
        fifteenMinsBtnOutlet.isUserInteractionEnabled = true
        fiveMinsBtnOutlet.isUserInteractionEnabled = true
        
        twoDaysBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        oneDayBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        threeHrsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        oneHrsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        fifteenMinsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        fiveMinsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
        
    }
    func updateReminderView() {
        let seconds = timeIntervalBetweenCurrentDateAndEventDate()
        if seconds > 172800 {
            twoDaysBeforeLabel.textColor = UIColor.darkGray
            oneDayBeforeLabel.textColor = UIColor.darkGray
            threeHoursBeforeLabel.textColor = UIColor.darkGray
            oneHourBeforeLabel.textColor = UIColor.darkGray
            fifteenMinsBeforeLabel.textColor = UIColor.darkGray
            fiveMinsBeforeLabel.textColor = UIColor.darkGray
        } else if seconds > 86400 {
            oneDayBeforeLabel.textColor = UIColor.darkGray
            threeHoursBeforeLabel.textColor = UIColor.darkGray
            oneHourBeforeLabel.textColor = UIColor.darkGray
            fifteenMinsBeforeLabel.textColor = UIColor.darkGray
            fiveMinsBeforeLabel.textColor = UIColor.darkGray
            twoDaysBtnOutlet.isUserInteractionEnabled = false
        } else if seconds > 10800 {
            threeHoursBeforeLabel.textColor = UIColor.darkGray
            oneHourBeforeLabel.textColor = UIColor.darkGray
            fifteenMinsBeforeLabel.textColor = UIColor.darkGray
            fiveMinsBeforeLabel.textColor = UIColor.darkGray
            twoDaysBtnOutlet.isUserInteractionEnabled = false
            oneDayBtnOutlet.isUserInteractionEnabled = false
        } else if seconds > 3600 {
            oneHourBeforeLabel.textColor = UIColor.darkGray
            fifteenMinsBeforeLabel.textColor = UIColor.darkGray
            fiveMinsBeforeLabel.textColor = UIColor.darkGray
            twoDaysBtnOutlet.isUserInteractionEnabled = false
            oneDayBtnOutlet.isUserInteractionEnabled = false
            threeHrsBtnOutlet.isUserInteractionEnabled = false
        } else if seconds > 900 {
            fifteenMinsBeforeLabel.textColor = UIColor.darkGray
            fiveMinsBeforeLabel.textColor = UIColor.darkGray
            twoDaysBtnOutlet.isUserInteractionEnabled = false
            oneDayBtnOutlet.isUserInteractionEnabled = false
            threeHrsBtnOutlet.isUserInteractionEnabled = false
            oneHrsBtnOutlet.isUserInteractionEnabled = false
        } else {
            fiveMinsBeforeLabel.textColor = UIColor.darkGray
            twoDaysBtnOutlet.isUserInteractionEnabled = false
            oneDayBtnOutlet.isUserInteractionEnabled = false
            threeHrsBtnOutlet.isUserInteractionEnabled = false
            oneHrsBtnOutlet.isUserInteractionEnabled = false
            fifteenMinsBtnOutlet.isUserInteractionEnabled = false
        }
    }
    func displayReminderLocalNotification(body: String) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            guard settings.authorizationStatus == .authorized else { return }
            let content = UNMutableNotificationContent()
            content.body = body
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
            let identifier = "iTagLocalNotification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    //Mark:- Check mark Btn Action
    @IBAction func checkMarkBtnAction(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 1:
            if twoDaysBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                twoDaysBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                twoDaysBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 2:
            if oneDayBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                oneDayBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                oneDayBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 3:
            if threeHrsBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                threeHrsBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                threeHrsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 4:
            if oneHrsBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                oneHrsBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                oneHrsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 5:
            if fifteenMinsBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                fifteenMinsBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                fifteenMinsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 6:
            if fiveMinsBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                fiveMinsBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                fiveMinsBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 7:
            if guestListBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                guestListBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                guestListBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 8:
            if groupBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                groupBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                groupBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        case 9:
            if taggedBtnOutlet.currentImage == UIImage(named: "unCheckMark"){
                taggedBtnOutlet.setImage(UIImage(named : "checkMark"), for: .normal)
            } else {
                taggedBtnOutlet.setImage(UIImage(named : "unCheckMark"), for: .normal)
            }
            break
        default:
            break
        }
    }
    //Mark :- Add profile btn action for Camera and Gallery
    @IBAction func addProfileBtnAction(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheetController.popoverPresentationController?.sourceView = self.contentView
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        let takePictureAction: UIAlertAction = UIAlertAction(title: "TakePhoto", style: .default) { action -> Void in
            self.openCameraPicker()
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "ChooseFromLibrary", style: .default) { action -> Void in
            self.openPhotoGallery()
        }
        actionSheetController.addAction(choosePictureAction)
        //Present the
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func openCameraPicker() {
        picker.sourceType = UIImagePickerController.SourceType.camera
        picker.cameraCaptureMode = .photo
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        present(picker,animated: true,completion: nil)
    }
    func openPhotoGallery() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true

        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imgPick.image = img
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgPick.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        var image : UIImage!
//
//        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//        {
//            image = img
//
//        }
//        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        {
//            image = img
//        }
//
//
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func showAlertPopUpWithTwoButton(title:String, message:String, leftButtonTitle : String,rightButtonTitle : String, completion : @escaping (_ leftButtonClicked: Bool, _ rightButtonClicked: Bool)->Void){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let leftBtnAction = UIAlertAction(title: leftButtonTitle, style: .default, handler: { (UIAlertAction)in
            completion(true,false)
        })
        alertController.addAction(leftBtnAction)
        
        let rightBtnAction = UIAlertAction(title: rightButtonTitle, style: .default, handler: { (UIAlertAction)in
            completion(false,true)
            
        })
        alertController.addAction(rightBtnAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //Mark :- Continue Btn Action Methods
    @IBAction func continueBtnAction(_ sender: Any) {
        
        if eventStartDate != nil  {
            let screenSize = textFieldsBaseView.bounds
            self.continueView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height:screenSize.height)
            self.continueView.tag = 150
            updateReminderView()
            textFieldsBaseView.addSubview(self.continueView)
        } else {
            self.showAlert(title: "", message: "Please select from Date")
        }
    }
    @IBAction func invitesClicked(_ sender:UIButton) {
//        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ContactsDashboardViewController") as! ContactsDashboardViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //Mark :- Picker Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return occurancePickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return occurancePickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        occuranceLabel.text = occurancePickerData[row]
    }
    @IBAction func createNewEvent(_ sender: Any) {
        
       // addNewEvents()
        
    }
//    func addNewEvents() {
//        var ImageArray : NSMutableArray!
//        let fromDate : String
//        let toDate : String
//        let fromTime : String
//        let toTime : String
//
//        if allBtnClicked == "true" {
//            var fromDateArr = fromDateLabel.text!.components(separatedBy: ",")
//            fromDate = fromDateArr[0]
//            fromTime = fromDateArr[1].replacingOccurrences(of: " ", with: "")
//            toDate = fromDateArr[0]
//            toTime = "23:59PM"
//
//        } else {
//            var fromDateArr = fromDateLabel.text!.components(separatedBy: ",")
//            fromDate = fromDateArr[0]
//            fromTime = fromDateArr[1].replacingOccurrences(of: " ", with: "")
//            var toDateArr   = toDateLabel.text!.components(separatedBy: ",")
//            toDate = toDateArr[0]
//            toTime  = toDateArr[1].replacingOccurrences(of: " ", with: "")
//        }
//        var remaindersListArr : [String] = []
//
//        if twoDaysBtnOutlet.currentImage == UIImage(named: "checkMark"){
//            remaindersListArr.append("2-day")
//        }
//        if oneDayBtnOutlet.currentImage == UIImage(named: "checkMark"){
//            remaindersListArr.append("1-day")
//        }
//        if threeHrsBtnOutlet.currentImage == UIImage(named: "checkMark"){
//            remaindersListArr.append("3-hours")
//        }
//        if oneHrsBtnOutlet.currentImage == UIImage(named: "checkMark"){
//            remaindersListArr.append("1-hours")
//        }
//        if fifteenMinsBtnOutlet.currentImage == UIImage(named: "checkMark"){
//            remaindersListArr.append("15-minutes")
//        }
//        if fiveMinsBtnOutlet.currentImage == UIImage(named: "checkMark"){
//            remaindersListArr.append("5-minutes")
//        }
//        print(remaindersListArr)
//
//        let data = ["eventName":eventNameField.text!,"eventMessage":messageField.text!,"eventDate":fromDate,"eventTime":fromTime, "eventEndDate":toDate,"eventEndTime":toTime, "isAllDayEvent":allBtnClicked, "isEventRepeatable":"true", "eventAddress":"Plot No. 82, Abburu Heights, Door. No:1-80/40/SP/82, Silpa Pioneer layout, Hi-tech City, Gachibowli, Serilingampally, Hyderabad, Telangana 500081", "eventCity":"Hyderabad", "location":["latitude":"17.440081","longitude":"78.348915"], "remindersList":["1-day","1-hours"], "eventFrequency":"Never", "numberOfOccurrences":"2", "showGuests":true, "status":"Draft", "createGroup":"true", "inviteeType":"individuals", "groupId":0, "guestList":[["userKey":"ef54983685274366ba339375ecda69df"], ["phoneNumber":"1234567890"], ["phoneNumber":"7731974613"]]] as [String : Any]
//        do {
//            let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//            let myJsonString  = NSString(data: json, encoding: String.Encoding.utf8.rawValue)! as String
//            let parameters : [String:String] = ["eventdetails":myJsonString]
//            guard let imageData = pickedImage?.pngData() else { return }
//            let ImageDic  = ["eventImage" : imageData]
//            ImageArray    = NSMutableArray(array: [ImageDic as NSDictionary])
//            postImageRequestWithURL(withUrl: "http://itaag.us-east-1.elasticbeanstalk.com/create/event/", withParam: parameters, withImages: ImageArray) { (isSuccess, response) in
//                if isSuccess {
//                    print(response)
//                } else {
//                    print(response)
//                }
//            }
//        } catch {
//            print("error")
//        }
//    }
//    func postImageRequestWithURL(withUrl strURL: String,withParam postParam: Dictionary<String, Any>,withImages imageArray:NSMutableArray,completion:@escaping (_ isSuccess: Bool, _ response:NSDictionary) -> Void) {
//
//        Alamofire.upload(multipartFormData: { (MultipartFormData) in
//            // Here is your Image Array
//            for (imageDic) in imageArray {
//                let imageDic = imageDic as! NSDictionary
//                for (key,valus) in imageDic {
//                    MultipartFormData.append(valus as! Data, withName:key as! String,fileName: "file.jpg", mimeType: "image/jpg")
//                }
//            }
//            // Here is your Post paramaters
//            for (key, value) in postParam {
//                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//            }
//        }, usingThreshold: UInt64.init(), to: strURL, method: .post, headers:["deviceid": "DEB8A7E5-F2EE-4D04-940A-EB0118D76EF3","userType":"personal","key":"9966022550"]) {(result) in
//            switch result {
//            case .success(let upload, _, _):
//                upload.uploadProgress(closure: {(progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                upload.responseJSON { response in
//                    if response.response?.statusCode == 200 {
//                        let json = response.result.value as? NSDictionary
//                        completion(true,json!);
//                    }
//                    else {
//                        let json = response.result.value as? NSDictionary
//                        completion(false,json!);
//                    }
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//                completion(false,[:]);
//            }
//        }
//    }
}
/*
 
 
 
 class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

     @IBOutlet var imageView:UIImageView!

     override func viewDidLoad() {
         super.viewDidLoad()

         self.openPhotoGallery()
     }

     func openPhotoGallery() {

         let picker = UIImagePickerController()
         picker.delegate = self
         picker.sourceType = .photoLibrary
         picker.allowsEditing = true
         picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
         present(picker, animated: true, completion: nil)
     }

     // MARK: - UIImagePickerControllerDelegate Methods
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

         if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
             imageView.image = img
         }
         dismiss(animated: true, completion: nil)
     }
 }
 */
 
