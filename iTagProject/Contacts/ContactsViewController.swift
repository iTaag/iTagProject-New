//
//  ContactsViewController.swift
//  LMS
//
//  Created by kranthi on 18/07/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit
import Contacts
import SwiftKeychainWrapper
class ContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var joinersTableView: UITableView!
    var phoneNum: String?
    var contacts = [CNContact]()
   // var phNumArray  = [String].self
    var phNumArray  = ["5555555544", "1212121212"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinersTableView.register(UINib(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        ContactsModel.shared.getLocalContacts {(contact) in
            self.contacts.append(contact!)
            print("all contects \(contact)")
            //self.callPostApi()
           // self.joinersTableView.reloadData()

        }
        //self.phNumArray.append(self.phoneNum ?? "")
        joinersTableView.reloadData()
        print("phone number array poooooooost ddiddloooadd\(phNumArray)")

        self.callPostApi()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        cell.nameLbl.text    = contacts[indexPath.row].givenName + " " + contacts[indexPath.row].familyName
        cell.empRoleLbl.text = contacts[indexPath.row].phoneNumbers.first?.value.stringValue
       // print("table phnums \(cell.empRoleLbl.text)")
        //self.phoneNum = cell.empRoleLbl.text
        //phNumArray.append((cell.empRoleLbl.text!))
        
        //print("phone number array \(phNumArray)")
        //phNumArray = ["8908908900","1111111111"]
        cell.inviteButn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)

        return cell
        
    }
    
    @objc func connected(sender: UIButton){
      print("in invite button Contact")
        
    }
    
    

        

//        func getPostData(params: [String:Any]) -> Data? {
//            return try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//            DispatchQueue.main.async {
//                //self.phNumArray.append(self.phoneNum ?? "")
//            self.joinersTableView.reloadData()
//            }
//        }

        func callPostApi() {
            //self.phNumArray.append(self.phoneNum ?? "")

            print("phone number array poooooooost\(phNumArray)")

            let url            = URL(string: "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/filter/taggedusers/")!
            var request        = URLRequest(url: url)
            request.httpMethod = "POST"

            let deviceId: String = "HardcodeDEVICEIDforiTaag222"

            let personalId: String = KeychainWrapper.standard.string(forKey: "USERID") ?? ""
            
            
            
            request.setValue(deviceId, forHTTPHeaderField: "deviceid")
            request.setValue(personalId, forHTTPHeaderField: "key")
            request.setValue("personal", forHTTPHeaderField: "userType")

            print("appende phone numbers \(phNumArray)")
            try? request.setMultipartFormData(["contactsList": "\(phNumArray)"], encoding: .utf8)
            DispatchQueue.main.async {
                               self.joinersTableView.reloadData()
                               }
            URLSession.shared.dataTask(with: request) { data, _, _ in
                if let data = data, let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {

                    print("contacts phonenumber filter json \(jsonObj)")
                    
//
//                    let filteredData = jsonObj.filter(jsonObj, {
//                    phNumArray.contain(jsonObj.phone)
//                    });
//                    let usernames = filteredData.value(for: "userName");
                    
                    
                  //  let filteredData = jsonObj.filter { phNumArray.contains($0.phone) }

                    
                    
                    
//
                    
                    
                    
                    
                    let user = jsonObj["5555555544"] as? [String: Any]
                    let name = user?["userName"] as? String
                    print("first username \(name)")

                }
            }.resume()
        }
        
    
//        func getPostData(params:[String:Any]) -> Data
//    {
//        return try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//    }
//
//    func callPostApi(){
//       // phNumArray = ["8908908900","1111111111", "5555555544"]
//
//        let url = URL(string: "http://itaag-env-1.ap-south-1.elasticbeanstalk.com/filter/taggedusers/")
//        guard let requestUrl = url else { fatalError() }
//        var request = URLRequest(url: requestUrl)
//        request.httpMethod = "POST"
//
//        request.setValue("EC3746E9-4DB4-42C7-9D8C-1542B18C2AC", forHTTPHeaderField: "deviceid")
//        request.setValue("5fe42fb3b54543a0bab5667cf96526f8", forHTTPHeaderField: "key")
//        request.setValue("personal", forHTTPHeaderField: "userType")
//
//        request.httpBody = getPostData(params: ["contactsList": "\(phNumArray)"])
//
//        // Perform HTTP Request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse!.statusCode)
//                // Check for Error
//                if let error = error {
//                    print("Error took place \(error)")
//                    return
//                }
//
//                // Convert HTTP Response Data to a String
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print("Response data string:\n \(dataString)")
//
//                   do {
//                       let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
//                        print("fetching json \(json)")
//                       let fetchStatus = json["userName"] as? String
//                       print("fetching json userName \(String(describing: fetchStatus))")
//
//                    let user = json["5555555544"] as? [String: Any]
//                    let name = user?["userName"] as? String
//
//                    print("firstusername \(name)")
//
//                   }
//                   catch{
//
//                    }
//
//                }
//        }
//        task.resume()
//    }

    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
            return 80
        }
        else{
        
        return 65.0
        }
    }
}


extension URLRequest {

    public mutating func setMultipartFormData(_ parameters: [String: String], encoding: String.Encoding) throws {

        let makeRandom = { UInt32.random(in: (.min)...(.max)) }
        let boundary = String(format: "------------------------%08X%08X", makeRandom(), makeRandom())

        let contentType: String = try {
            guard let charset = CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(encoding.rawValue)) else {
                throw MultipartFormDataEncodingError.characterSetName
            }
            return "multipart/form-data; charset=\(charset); boundary=\(boundary)"
        }()
        addValue(contentType, forHTTPHeaderField: "Content-Type")

        httpBody = try {
            var body = Data()

            for (rawName, rawValue) in parameters {
                if !body.isEmpty {
                    body.append("\r\n".data(using: .utf8)!)
                }

                body.append("--\(boundary)\r\n".data(using: .utf8)!)

                guard
                    rawName.canBeConverted(to: encoding),
                    let disposition = "Content-Disposition: form-data; name=\"\(rawName)\"\r\n".data(using: encoding) else {
                    throw MultipartFormDataEncodingError.name(rawName)
                }
                body.append(disposition)

                body.append("\r\n".data(using: .utf8)!)

                guard let value = rawValue.data(using: encoding) else {
                    throw MultipartFormDataEncodingError.value(rawValue, name: rawName)
                }

                body.append(value)
            }

            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            return body
        }()
    }
}

public enum MultipartFormDataEncodingError: Error {
    case characterSetName
    case name(String)
    case value(String, name: String)
}




