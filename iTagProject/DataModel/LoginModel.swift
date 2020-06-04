//
//  LoginModel .swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 15, 2019

import Foundation


class LoginModel  : NSObject, NSCoding {

    var userExists : String!
    var userId : String!
    var success : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        userExists = dictionary["userExists"] as? String
        userId = dictionary["userId"] as? String
        success = dictionary["Success"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if userExists != nil{
            dictionary["userExists"] = userExists
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if success != nil{
            dictionary["Success"] = success
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        userExists = aDecoder.decodeObject(forKey: "userExists") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        success = aDecoder.decodeObject(forKey: "Success") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if userExists != nil{
            aCoder.encode(userExists, forKey: "userExists")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if success != nil{
            aCoder.encode(success, forKey: "Success")
        }
    }
}
