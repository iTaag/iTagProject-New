//
//  EventsModelGuestList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2019

import Foundation


class EventsModelGuestList : NSObject, NSCoding{

    var eventId : String!
    var userKey : String!
    var userType : String!
    var guestName : AnyObject!
    var guestProfilePic : AnyObject!
    var phoneNumber : AnyObject!
    var guestType : String!
    var rsvpStatus : String!
    var adultCount : Int!
    var kidCount : Int!
    var iTaagRegistrationStatus : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        eventId = dictionary["eventId"] as? String
        userKey = dictionary["userKey"] as? String
        userType = dictionary["userType"] as? String
        guestName = dictionary["guestName"] as? AnyObject
        guestProfilePic = dictionary["guestProfilePic"] as? AnyObject
        phoneNumber = dictionary["phoneNumber"] as? AnyObject
        guestType = dictionary["guestType"] as? String
        rsvpStatus = dictionary["rsvpStatus"] as? String
        adultCount = dictionary["adultCount"] as? Int
        kidCount = dictionary["kidCount"] as? Int
        iTaagRegistrationStatus = dictionary["iTaagRegistrationStatus"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if eventId != nil{
            dictionary["eventId"] = eventId
        }
        if userKey != nil{
            dictionary["userKey"] = userKey
        }
        if userType != nil{
            dictionary["userType"] = userType
        }
        if guestName != nil{
            dictionary["guestName"] = guestName
        }
        if guestProfilePic != nil{
            dictionary["guestProfilePic"] = guestProfilePic
        }
        if phoneNumber != nil{
            dictionary["phoneNumber"] = phoneNumber
        }
        if guestType != nil{
            dictionary["guestType"] = guestType
        }
        if rsvpStatus != nil{
            dictionary["rsvpStatus"] = rsvpStatus
        }
        if adultCount != nil{
            dictionary["adultCount"] = adultCount
        }
        if kidCount != nil{
            dictionary["kidCount"] = kidCount
        }
        if iTaagRegistrationStatus != nil{
            dictionary["iTaagRegistrationStatus"] = iTaagRegistrationStatus
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        eventId = aDecoder.decodeObject(forKey: "eventId") as? String
        userKey = aDecoder.decodeObject(forKey: "userKey") as? String
        userType = aDecoder.decodeObject(forKey: "userType") as? String
        guestName = aDecoder.decodeObject(forKey: "guestName") as? AnyObject
        guestProfilePic = aDecoder.decodeObject(forKey: "guestProfilePic") as? AnyObject
        phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? AnyObject
        guestType = aDecoder.decodeObject(forKey: "guestType") as? String
        rsvpStatus = aDecoder.decodeObject(forKey: "rsvpStatus") as? String
        adultCount = aDecoder.decodeObject(forKey: "adultCount") as? Int
        kidCount = aDecoder.decodeObject(forKey: "kidCount") as? Int
        iTaagRegistrationStatus = aDecoder.decodeObject(forKey: "iTaagRegistrationStatus") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if eventId != nil{
            aCoder.encode(eventId, forKey: "eventId")
        }
        if userKey != nil{
            aCoder.encode(userKey, forKey: "userKey")
        }
        if userType != nil{
            aCoder.encode(userType, forKey: "userType")
        }
        if guestName != nil{
            aCoder.encode(guestName, forKey: "guestName")
        }
        if guestProfilePic != nil{
            aCoder.encode(guestProfilePic, forKey: "guestProfilePic")
        }
        if phoneNumber != nil{
            aCoder.encode(phoneNumber, forKey: "phoneNumber")
        }
        if guestType != nil{
            aCoder.encode(guestType, forKey: "guestType")
        }
        if rsvpStatus != nil{
            aCoder.encode(rsvpStatus, forKey: "rsvpStatus")
        }
        if adultCount != nil{
            aCoder.encode(adultCount, forKey: "adultCount")
        }
        if kidCount != nil{
            aCoder.encode(kidCount, forKey: "kidCount")
        }
        if iTaagRegistrationStatus != nil{
            aCoder.encode(iTaagRegistrationStatus, forKey: "iTaagRegistrationStatus")
        }
    }
}