//
//  CampsModelBusinessAddress.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 30, 2019

import Foundation


class CampsModelBusinessAddress : NSObject, NSCoding{

    var addressId : String!
    var userId : String!
    var addressName : AnyObject!
    var pincode : String!
    var city : String!
    var streetName : String!
    var colony : String!
    var landMark : String!
    var state : AnyObject!
    var status : String!
    var type : String!
    var dateCreated : String!
    var dateModified : String!
    var location : CampsModelLocation!
    var bldgComplexName : String!
    var storeUnitNumber : String!
    var plotNo : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        addressId = dictionary["addressId"] as? String
        userId = dictionary["userId"] as? String
        addressName = dictionary["addressName"] as? AnyObject
        pincode = dictionary["pincode"] as? String
        city = dictionary["city"] as? String
        streetName = dictionary["streetName"] as? String
        colony = dictionary["colony"] as? String
        landMark = dictionary["landMark"] as? String
        state = dictionary["state"] as? AnyObject
        status = dictionary["status"] as? String
        type = dictionary["type"] as? String
        dateCreated = dictionary["dateCreated"] as? String
        dateModified = dictionary["dateModified"] as? String
        bldgComplexName = dictionary["bldgComplexName"] as? String
        storeUnitNumber = dictionary["storeUnitNumber"] as? String
        plotNo = dictionary["plotNo"] as? String
        if let locationData = dictionary["location"] as? [String:Any]{
            location = CampsModelLocation(fromDictionary: locationData)
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
        if userId != nil{
            dictionary["userId"] = userId
        }
        if addressName != nil{
            dictionary["addressName"] = addressName
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
        if bldgComplexName != nil{
            dictionary["bldgComplexName"] = bldgComplexName
        }
        if storeUnitNumber != nil{
            dictionary["storeUnitNumber"] = storeUnitNumber
        }
        if plotNo != nil{
            dictionary["plotNo"] = plotNo
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
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        addressName = aDecoder.decodeObject(forKey: "addressName") as? Any as AnyObject?
        pincode = aDecoder.decodeObject(forKey: "pincode") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        streetName = aDecoder.decodeObject(forKey: "streetName") as? String
        colony = aDecoder.decodeObject(forKey: "colony") as? String
        landMark = aDecoder.decodeObject(forKey: "landMark") as? String
        state = aDecoder.decodeObject(forKey: "state") as? AnyObject
        status = aDecoder.decodeObject(forKey: "status") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? String
        dateModified = aDecoder.decodeObject(forKey: "dateModified") as? String
        location = aDecoder.decodeObject(forKey: "location") as? CampsModelLocation
        bldgComplexName = aDecoder.decodeObject(forKey: "bldgComplexName") as? String
        storeUnitNumber = aDecoder.decodeObject(forKey: "storeUnitNumber") as? String
        plotNo = aDecoder.decodeObject(forKey: "plotNo") as? String
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
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if addressName != nil{
            aCoder.encode(addressName, forKey: "addressName")
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
        if bldgComplexName != nil{
            aCoder.encode(bldgComplexName, forKey: "bldgComplexName")
        }
        if storeUnitNumber != nil{
            aCoder.encode(storeUnitNumber, forKey: "storeUnitNumber")
        }
        if plotNo != nil{
            aCoder.encode(plotNo, forKey: "plotNo")
        }
    }
}
