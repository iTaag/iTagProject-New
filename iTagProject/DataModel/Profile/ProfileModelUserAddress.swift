//
//  ProfileModelUserAddress.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 30, 2019

import Foundation


class ProfileModelUserAddress : NSObject, NSCoding{

    var addressId : String!
    var addressName : String!
    var userId : String!
    var pincode : String!
    var city : String!
    var streetName : String!
    var houseNo : String!
    var buildingName : String!
    var apartmentNumber : String!
    var colony : String!
    var landMark : String!
    var state : String!
    var status : String!
    var type : String!
    var dateCreated : String!
    var dateModified : String!
    var location : ProfileModelLocation!
    var deepLink : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        addressId = dictionary["addressId"] as? String
        addressName = dictionary["addressName"] as? String
        userId = dictionary["userId"] as? String
        pincode = dictionary["pincode"] as? String
        city = dictionary["city"] as? String
        streetName = dictionary["streetName"] as? String
        houseNo = dictionary["houseNo"] as? String
        buildingName = dictionary["buildingName"] as? String
        apartmentNumber = dictionary["apartmentNumber"] as? String
        colony = dictionary["colony"] as? String
        landMark = dictionary["landMark"] as? String
        state = dictionary["state"] as? String
        status = dictionary["status"] as? String
        type = dictionary["type"] as? String
        dateCreated = dictionary["dateCreated"] as? String
        dateModified = dictionary["dateModified"] as? String
        deepLink = dictionary["deepLink"] as? String
        if let locationData = dictionary["location"] as? [String:Any]{
            location = ProfileModelLocation(fromDictionary: locationData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if addressId != nil{
            dictionary["addressId"] = addressId
        }
        if addressName != nil{
            dictionary["addressName"] = addressName
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if pincode != nil{
            dictionary["pincode"] = pincode
        }
        if city != nil{
            dictionary["city"] = city
        }
        if streetName != nil{
            dictionary["streetName"] = streetName
        }
        if houseNo != nil{
            dictionary["houseNo"] = houseNo
        }
        if buildingName != nil{
            dictionary["buildingName"] = buildingName
        }
        if apartmentNumber != nil{
            dictionary["apartmentNumber"] = apartmentNumber
        }
        if colony != nil{
            dictionary["colony"] = colony
        }
        if landMark != nil{
            dictionary["landMark"] = landMark
        }
        if state != nil{
            dictionary["state"] = state
        }
        if status != nil{
            dictionary["status"] = status
        }
        if type != nil{
            dictionary["type"] = type
        }
        if dateCreated != nil{
            dictionary["dateCreated"] = dateCreated
        }
        if dateModified != nil{
            dictionary["dateModified"] = dateModified
        }
        if deepLink != nil{
            dictionary["deepLink"] = deepLink
        }
        if location != nil{
            dictionary["location"] = location.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addressId = aDecoder.decodeObject(forKey: "addressId") as? String
        addressName = aDecoder.decodeObject(forKey: "addressName") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        pincode = aDecoder.decodeObject(forKey: "pincode") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        streetName = aDecoder.decodeObject(forKey: "streetName") as? String
        houseNo = aDecoder.decodeObject(forKey: "houseNo") as? String
        buildingName = aDecoder.decodeObject(forKey: "buildingName") as? String
        apartmentNumber = aDecoder.decodeObject(forKey: "apartmentNumber") as? String
        colony = aDecoder.decodeObject(forKey: "colony") as? String
        landMark = aDecoder.decodeObject(forKey: "landMark") as? String
        state = aDecoder.decodeObject(forKey: "state") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? String
        dateModified = aDecoder.decodeObject(forKey: "dateModified") as? String
        location = aDecoder.decodeObject(forKey: "location") as? ProfileModelLocation
        deepLink = aDecoder.decodeObject(forKey: "deepLink") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if addressId != nil{
            aCoder.encode(addressId, forKey: "addressId")
        }
        if addressName != nil{
            aCoder.encode(addressName, forKey: "addressName")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if pincode != nil{
            aCoder.encode(pincode, forKey: "pincode")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if streetName != nil{
            aCoder.encode(streetName, forKey: "streetName")
        }
        if houseNo != nil{
            aCoder.encode(houseNo, forKey: "houseNo")
        }
        if buildingName != nil{
            aCoder.encode(buildingName, forKey: "buildingName")
        }
        if apartmentNumber != nil{
            aCoder.encode(apartmentNumber, forKey: "apartmentNumber")
        }
        if colony != nil{
            aCoder.encode(colony, forKey: "colony")
        }
        if landMark != nil{
            aCoder.encode(landMark, forKey: "landMark")
        }
        if state != nil{
            aCoder.encode(state, forKey: "state")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if dateCreated != nil{
            aCoder.encode(dateCreated, forKey: "dateCreated")
        }
        if dateModified != nil{
            aCoder.encode(dateModified, forKey: "dateModified")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if deepLink != nil{
            aCoder.encode(deepLink, forKey: "deepLink")
        }
    }
}



















/*

class ProfileModelUserAddress : NSObject, NSCoding{
    var pincode : String!
    var city : String!
    var streetName : String!
    
    init(fromDictionary dictionary: [String:Any]){
        pincode = dictionary["pincode"] as? String
        city = dictionary["city"] as? String
        streetName = dictionary["streetName"] as? String
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
      
        if pincode != nil{
            dictionary["pincode"] = pincode
        }
        if city != nil{
            dictionary["city"] = city
        }
        if streetName != nil{
            dictionary["streetName"] = streetName
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        pincode = aDecoder.decodeObject(forKey: "pincode") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        streetName = aDecoder.decodeObject(forKey: "streetName") as? String
    }

    @objc func encode(with aCoder: NSCoder)
    {
        if pincode != nil{
            aCoder.encode(pincode, forKey: "pincode")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if streetName != nil{
            aCoder.encode(streetName, forKey: "streetName")
        }
    }
}

*/
