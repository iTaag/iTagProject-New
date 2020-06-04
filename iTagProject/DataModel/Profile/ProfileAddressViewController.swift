//
//  ProfileAddressViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 27/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SwiftKeychainWrapper
class ProfileAddressViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate, DataEnteredDelegate {
    
    var addressModel : ProfileModelUserAddress?

    var userModel : ProfileModel?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contenScrollView: UIScrollView!
    @IBOutlet weak var pincodeField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var plotField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var storeNoField: UITextField!
    @IBOutlet weak var appormentNoField: UITextField!
    @IBOutlet weak var colonyField: UITextField!
    @IBOutlet weak var landmarkField: UITextField!
    @IBOutlet weak var phoneBgView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    let searchCont = UISearchController(searchResultsController: nil)
    let annotation = MKPointAnnotation()

    var savedUserid: String?
        
    var datePicker = UIDatePicker()
    
//    let genderDropDown = DropDown()
//    let maritalStatusDropDown = DropDown()
    //var calender: FSCalendar!
    var calenderBgView = UIView()
    var appDelegate: AppDelegate=AppDelegate()
//  let dataBase=DataBase()
    let locationManager = CLLocationManager()
    var latitude: String?
    var logitude: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // self.navigationBarButton()
        contenScrollView.contentSize=CGSize(width: contenScrollView.frame.size.width, height: phoneBgView.frame.origin.y+phoneBgView.frame.size.height+200)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){

        contenScrollView.isScrollEnabled = false
        contenScrollView.contentSize=CGSize(width: contenScrollView.frame.size.width, height: phoneBgView.frame.origin.y+phoneBgView.frame.size.height)
        }
        
        saveaddAddressService()
       
        
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            //adjust size for iPads
//
//        }
        hideKeyboardWhenTappedAround()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true;
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.triggerTouchAction(_:)))
        mapView.addGestureRecognizer(tapGesture)
               
    }
    @objc func triggerTouchAction(_ sender: UITapGestureRecognizer) {
        print("Please Help!")
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewZoomAddressViewController") as! NewZoomAddressViewController;
            viewController.delegate = self
        
        viewController.zipName = self.pincodeField.text
        viewController.sublocalityName = self.colonyField.text
        viewController.localityName = self.cityField.text
            self.navigationController?.pushViewController(viewController, animated: true);
    }

    @objc func backButtonClicked(sender:UIButton) {
        self.navigationController?.popViewController(animated: true);
    }
    func userDidEnterInformation(info: DataEnteredModelSave) {
        print("map address viewcontroller data \(info)")
        self.pincodeField.text = info.pinCode
        self.streetField.text = info.streetField
        self.cityField.text = info.cityField
//
//        addressModel?.pincode = self.pincodeField.text
//        addressModel?.city = self.cityField.text
//       // userModel?.userAddresses?[addressModel?.pincode, addressModel?.city]

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewZoomAddressViewController") as! NewZoomAddressViewController;
                    viewController.delegate = self
                
                viewController.zipName = self.pincodeField.text
                viewController.sublocalityName = self.colonyField.text
                viewController.localityName = self.cityField.text
                    self.navigationController?.pushViewController(viewController, animated: true);
//
////        savedUserid = KeychainWrapper.standard.string(forKey: "USERID")
//        if savedUserid == nil
//        {
//            if addresValidation() == true {
//                      // self.addressregistarion()
//                   }
//        }
//        else{
//
//            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewZoomAddressViewController") as! NewZoomAddressViewController;
//            self.navigationController?.pushViewController(viewController, animated: true);
//        }
    }
    
    func addresValidation() -> Bool {
        if (pincodeField.text?.count)!<1 {
            self.showAlertView(alertViewTitle: "", Message: "Please Enter Pincode", on: self)
            return false
        }
        else if (cityField.text?.count)!<1 {
            self.showAlertView(alertViewTitle: "", Message: "Please Enter City", on: self)
            return false
        } else if (colonyField.text?.count)!<1 {
            self.showAlertView(alertViewTitle: "", Message: "Please Enter Colony", on: self)
            return false
        }
        return true
    }
    func showAlertView(alertViewTitle title: String, Message message: String, on controller: UIViewController) {
        var title1=title
        
        if title1.count<1 {
            title1="Alert"
        }
        
        let alertView = UIAlertController(title: title1, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        controller.present(alertView, animated: true, completion: nil)
    }

//    MARK:- Search Address
    @IBAction func searchLocationButton(_ sender: Any) {
       // let searchCont = UISearchController(searchResultsController: nil)
        searchCont.searchBar.delegate = self
        searchCont.searchBar.backgroundColor = .blue
        present(searchCont, animated:true, completion:nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        //create the search request
        let searchReq = MKLocalSearch.Request()
        searchReq.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchReq)
        activeSearch.start { (response, error) in
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil{
                print("error")
            }
            else{
                //remove annotation
                //let annotations = self.mapView.annotations
               // self.mapView.removeAnnotation(annotations as! MKAnnotation)
                //getting data
                let lat = response?.boundingRegion.center.latitude
                let long = response?.boundingRegion.center.longitude
                //create annotation
                //let annotation = MKPointAnnotation()
                self.annotation.title = searchBar.text
                self.annotation.coordinate = CLLocationCoordinate2DMake(lat!, long!)
                self.mapView.addAnnotation(self.annotation)
                //zooming annotation
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, long!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                
                
                // Add below code to get search address
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: lat!, longitude: long!)
                      geoCoder.reverseGeocodeLocation(location, completionHandler:
                          {
                              placemarks, error -> Void in

                              // Place details
                              guard let placeMark = placemarks?.first else { return }

                              // Location name
                            
                            self.pincodeField.text = placeMark.postalCode
                            self.colonyField.text = placeMark.locality
                            self.streetField.text = placeMark.subLocality
                            
                            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewZoomAddressViewController") as! NewZoomAddressViewController;
                                viewController.delegate = self
                            
                            viewController.zipName = self.pincodeField.text
                            viewController.sublocalityName = self.colonyField.text
                            viewController.localityName = self.streetField.text
                            self.navigationController?.pushViewController(viewController, animated: true);

                      })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        let userLocation :CLLocation = locations[0] as CLLocation
        latitude = "\(userLocation.coordinate.latitude)"
        logitude = "\(userLocation.coordinate.longitude)"
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            
            if self.searchCont.searchBar.text == nil{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                print("current location")

                let placemarkDictonary: NSDictionary=placemark.addressDictionary as! NSDictionary
                self.pincodeField.text=placemarkDictonary["ZIP"] as? String
                self.cityField.text=placemarkDictonary["City"] as? String
                self.plotField.text=placemarkDictonary["Name"] as? String
                self.streetField.text=placemarkDictonary["Street"] as? String
                self.appormentNoField.text=placemarkDictonary["SubThoroughfare"] as? String
                self.colonyField.text=placemarkDictonary["SubLocality"] as? String
                self.landmarkField.text=placemarkDictonary["SubThoroughfare"] as? String
                
            }
            
            else{
                print("search location")

                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.subLocality!)
                print(placemark.postalCode!)

                print(placemark.administrativeArea!)
                print(placemark.country!)
                let placemarkDictonary: NSDictionary=placemark.addressDictionary as! NSDictionary
                self.pincodeField.text=placemarkDictonary["ZIP"] as? String
                self.cityField.text=placemarkDictonary["City"] as? String
                self.plotField.text=placemarkDictonary["Name"] as? String
                self.streetField.text=placemarkDictonary["Street"] as? String
                self.appormentNoField.text=placemarkDictonary["SubThoroughfare"] as? String
                self.colonyField.text=placemarkDictonary["SubLocality"] as? String
                self.landmarkField.text=placemarkDictonary["SubThoroughfare"] as? String
            }
            
            
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                let placemarkDictonary: NSDictionary=placemark.addressDictionary as! NSDictionary
                self.pincodeField.text=placemarkDictonary["ZIP"] as? String
                self.cityField.text=placemarkDictonary["City"] as? String
                self.plotField.text=placemarkDictonary["Name"] as? String
                self.streetField.text=placemarkDictonary["Street"] as? String
                self.appormentNoField.text=placemarkDictonary["SubThoroughfare"] as? String
                self.colonyField.text=placemarkDictonary["SubLocality"] as? String
                self.landmarkField.text=placemarkDictonary["SubThoroughfare"] as? String
            }
        }
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("User still thinking")
        case .denied:
            print("User hates you")
        case .authorizedWhenInUse:
            locationManager.stopUpdatingLocation()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted:
            print("User dislikes you")
        }
    }
    
    
    
    func saveaddAddressService(){
           // let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        
            let deviceId: String = "HardcodeDEVICEIDforiTaag222"

            let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""

            //let personalId: String = UserDefaults.standard.string(forKey: "USERID") ?? ""
            let headers = ["deviceid": deviceId,"userType": "personal","key": "5fe42fb3b54543a0bab5667cf96526f8"]
        let locations: [String: Any] = ["longitude": logitude as Any,"latitude": latitude as Any]
        let parameters: [String: Any] = [
                    "pincode": pincodeField.text!,
                    "city": cityField.text as Any,
                    "streetName": streetField.text as Any,
                    "colony": colonyField.text as Any,
                    "landMark": landmarkField.text as Any,
                    "state": "",
                    "plotNo": plotField.text as Any,
                    "bldgComplexName": "",
                    "Complex": "",
                    "userName": "",
                    "password": "",
                    "location" : locations
                ]
            let string = "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/saveaddress/"
            var urlComponents = URLComponents(string: string)
            let requestedUserType = URLQueryItem(name: "requestedUserType", value: "personal")

            let requestedItem = URLQueryItem(name: "addressType", value: "Other")
        
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        print(jsonString)
        //var request = URLRequest(url: url!)
        //request.httpMethod = "POST"
                
        
            urlComponents?.queryItems = [requestedItem, requestedUserType]
            let urlStr = urlComponents?.url
            
            let request = NSMutableURLRequest(url: urlStr!, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
            request.httpMethod = "POST"
            let postData = String(format: "addressdetails=%@",jsonString) .data(using: .utf8)
            request.httpBody = postData
            request.allHTTPHeaderFields = headers as! [String : String]
        
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    let httpResponse = response as? HTTPURLResponse
                    if httpResponse!.statusCode == 200 {
                        do {
                            let jsonObject  = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String: Any]

                            print("location textfield values \(jsonString)")

                            self.addressModel = ProfileModelUserAddress.init(fromDictionary: parameters)

                            print("saved address json in profile address\(jsonObject)")
                            
                            
                        } catch { print(error.localizedDescription) }
                    } else {
                        //Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again", on: self)
                        
                    }
                }
            })
            dataTask.resume()
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func addressregistarion() {
////        let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
////
////       // let deviceId: String=(UIDevice.current.identifierForVendor?.uuidString)!
////        let phone: String = UserDefaults.standard.value(forKey: "PhoneNumber") as! String
////        let headers = [ "deviceid": deviceId,"userType": "personal","key": phone]
//
//
//        let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
//        let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""
//
//        //let personalId: String = UserDefaults.standard.string(forKey: "USERID") ?? ""
//        let headers = ["deviceid": deviceId,"userType": "personal","key": personalId]
//
//
//
//        let locations: [String: Any] = ["longitude": logitude as Any,"latitude": latitude as Any]
//
//        let parameters: [String: Any] = [
//            "pincode": pincodeField.text!,
//            "city": cityField.text as Any,
//            "streetName": streetField.text as Any,
//            "colony": colonyField.text as Any,
//            "landMark": landmarkField.text as Any,
//            "state": "",
//            "plotNo": plotField.text as Any,
//            "bldgComplexName": "",
//            "Complex": "",
//            "userName": "",
//            "password": "",
//            "location" : locations
//        ]
//        let URL_HEROES = Constants.GLOBAL_URL + "/saveaddress/"
//        let url = URL (string:URL_HEROES )
//        var _ : NSError?
//        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//        print(jsonString)
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        let postData = String(format: "addressdetails=%@",jsonString) .data(using: .utf8)
//        request.httpBody = postData
//        request.allHTTPHeaderFields = headers
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error!)
//            } else {
//                if let jsonObj = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary) as NSDictionary??) {
//                    if (jsonObj?.count)!<1 {
//                        DispatchQueue.main.async {
//                            Constants.showAlertView(alertViewTitle: "", Message: "Please enter vaild details", on: self)
//                        }
//                    }
//                    else {
//                        let httpResponse = response as? HTTPURLResponse
//                        if httpResponse!.statusCode == 200 {
//                            let addressID: String = jsonObj?["addressId"] as? String ?? ""
//                            print(addressID)
//                            if addressID.isEmpty {
//                                print(addressID)
//                            }
//                            else{
//                                DispatchQueue.main.async {
////                                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TermsAndConditionsViewController1") as! TermsAndConditionsViewController1;
////                                    UserDefaults.standard.set(addressID, forKey:"ADDRESSID")
////                                    self.navigationController?.pushViewController(viewController, animated: true);
//
//
//                                    self.navigationController?.popViewController(animated: true)
//
//                                }
//                            }
//                            print(jsonObj as Any)
//                        }
//                        else {
//                            Constants.showAlertView(alertViewTitle: "", Message: "OTP not yet validated", on: self)
//                        }
//                    }
//                }
//            }
//        })
//        dataTask.resume()
//    }
}
