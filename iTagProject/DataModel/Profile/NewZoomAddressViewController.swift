//
//  NewZoomAddressViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 25/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftKeychainWrapper
protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: DataEnteredModelSave)
}

class NewZoomAddressViewController: UIViewController {
    weak var delegate: DataEnteredDelegate? = nil
    //var userModel : ProfileModel?
    var addressModel: ProfileModelUserAddress?
    var addressArray = [String]()
    var zipName: String?
    var localityName: String?
    var sublocalityName: String?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in Zoom map VC")
        mapView.delegate = self
        addressLabel.text = "\(self.sublocalityName!) \(localityName!) \(self.zipName!)"
        //self.delegate = (self.navigationController?.viewControllers.first as! DataEnteredDelegate)

  //      saveaddAddressService()
        
        checkLocationServices()
        
    }
    @IBAction func backBtn(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    @IBAction func confirmBtn(_ sender: Any) {
        
        let viewController2 = storyboard?.instantiateViewController(withIdentifier: "Add_EditAddressViewController") as! Add_EditAddressViewController
        addressArray.append("\(sublocalityName ?? "") \(zipName ?? "") \(localityName ?? "")")
        viewController2.addressArray = addressArray
        navigationController?.pushViewController(viewController2, animated: true)
        
    }
    
    //var viewController: UIViewController?

//    @IBAction func confirmBtn(_ sender: Any) {
//        let viewController = storyboard?.instantiateViewController(withIdentifier: "Add_EditAddressViewController") as! Add_EditAddressViewController
//        addressArray.append("\(sublocalityName ?? "") \(zipName ?? "") \(localityName ?? "")")
//        viewController.addressArray = addressArray
//        navigationController?.pushViewController(viewController, animated: true)
//    }
    
//
//        @IBAction func confirmBtn(_ sender: Any) {
//            let viewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//            addressArray.append("\(sublocalityName ?? "") \(zipName ?? "") \(localityName ?? "")")
//            viewController.addressArray = addressArray
//            navigationController?.pushViewController(viewController, animated: true)
//        }
//
    
    @IBAction func changeBtn(_ sender: Any) {
        
        //delegate?.userDidEnterInformation(info: [zipName!,sublocalityName!, localityName!])
        
        guard
               let zipName = zipName,
               let sublocalityName = sublocalityName,
               let localityName = localityName
               else { return }
           let enteredData = DataEnteredModelSave(pinCode: zipName, streetField: sublocalityName, cityField: localityName)
           delegate?.userDidEnterInformation(info: enteredData)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    func saveaddAddressService(){
            //let deviceId: String = "HardcodeDEVICEIDforiTaag"//(UIDevice.current.identifierForVendor?.uuidString)!
        let deviceId: String = "HardcodeDEVICEIDforiTaag222"

            let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""

            //let personalId: String = UserDefaults.standard.string(forKey: "USERID") ?? ""
            let headers = ["deviceid": deviceId,"userType": "personal","key": "5fe42fb3b54543a0bab5667cf96526f8"]
        let parameters: [String: Any] = [
            "pincode":"500006", "city":"Bangalore","houseNo":"50", "streetName":"7th Main", "buildingName":"ABC Appartments", "apartmentNumber":"404", "colony":"Koramangala", "landMark":"Opp. Bus Stand", "state":"Karnataka", "location":["longitude":"34.494847","latitude":"54.34283"]
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

                            print("saved address json \(jsonObject)")
                            
                            
                        } catch { print(error.localizedDescription) }
                    } else {
                        //Constants.showAlertView(alertViewTitle: "", Message: "Something went wrong, Please try again", on: self)
                        
                    }
                }
            })
            dataTask.resume()
        }
}



extension NewZoomAddressViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


extension NewZoomAddressViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            
//
//            if (self.userModel?.userId) != nil {
//
//
//            }
            
            
            
            
            
            
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""//locality
            self.localityName = placemark.locality ?? ""//locality
            self.sublocalityName = placemark.subLocality ?? ""//locality
            self.zipName = placemark.postalCode ?? ""//locality
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(self.sublocalityName!) \(self.localityName!) \(self.zipName!)"
                print("zzooom map location label \(self.addressLabel.text)")
                
//
//                self.addressModel?.pincode = self.zipName!
//                self.addressModel?.streetName = self.sublocalityName!
//                self.addressModel?.city = self.localityName!
//
//
//                print("model values \(self.addressModel?.pincode)")
//                print("model values \(self.addressModel?.streetName)")
                
                
            }
        }
    }
}






    

