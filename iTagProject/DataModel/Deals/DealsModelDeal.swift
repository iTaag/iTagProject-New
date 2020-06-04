//
//  DealsModelDeal.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 22, 2019

import Foundation


class DealsModelDeal : NSObject, NSCoding{

    var businessId : String!
    var businessName : String!
    var businessPhone : String!
    var businessProfilePic : String!
    var businessAddress : DealsModelBusinessAddress!
    var dealId : String!
    var dealName : String!
    var dealDescription : String!
    var dealImageUrl : AnyObject!
    var dealCode : String!
    var startDate : String!
    var endDate : String!
    var publishingCriteria : String!
    var criteriaValue : String!
    var status : String!
    var publishedDate : AnyObject!
    var applicableToNetwork : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        businessId = dictionary["businessId"] as? String
        businessName = dictionary["businessName"] as? String
        businessPhone = dictionary["businessPhone"] as? String
        businessProfilePic = dictionary["businessProfilePic"] as? String
        dealId = dictionary["dealId"] as? String
        dealName = dictionary["dealName"] as? String
        dealDescription = dictionary["dealDescription"] as? String
        dealImageUrl = dictionary["dealImageUrl"] as? AnyObject
        dealCode = dictionary["dealCode"] as? String
        startDate = dictionary["startDate"] as? String
        endDate = dictionary["endDate"] as? String
        publishingCriteria = dictionary["publishingCriteria"] as? String
        criteriaValue = dictionary["criteriaValue"] as? String
        status = dictionary["status"] as? String
        publishedDate = dictionary["publishedDate"] as? AnyObject
        applicableToNetwork = dictionary["applicableToNetwork"] as? Bool
        if let businessAddressData = dictionary["businessAddress"] as? [String:Any]{
            businessAddress = DealsModelBusinessAddress(fromDictionary: businessAddressData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if businessId != nil{
            dictionary["businessId"] = businessId
        }
        if businessName != nil{
            dictionary["businessName"] = businessName
        }
        if businessPhone != nil{
            dictionary["businessPhone"] = businessPhone
        }
        if businessProfilePic != nil{
            dictionary["businessProfilePic"] = businessProfilePic
        }
        if dealId != nil{
            dictionary["dealId"] = dealId
        }
        if dealName != nil{
            dictionary["dealName"] = dealName
        }
        if dealDescription != nil{
            dictionary["dealDescription"] = dealDescription
        }
        if dealImageUrl != nil{
            dictionary["dealImageUrl"] = dealImageUrl
        }
        if dealCode != nil{
            dictionary["dealCode"] = dealCode
        }
        if startDate != nil{
            dictionary["startDate"] = startDate
        }
        if endDate != nil{
            dictionary["endDate"] = endDate
        }
        if publishingCriteria != nil{
            dictionary["publishingCriteria"] = publishingCriteria
        }
        if criteriaValue != nil{
            dictionary["criteriaValue"] = criteriaValue
        }
        if status != nil{
            dictionary["status"] = status
        }
        if publishedDate != nil{
            dictionary["publishedDate"] = publishedDate
        }
        if applicableToNetwork != nil{
            dictionary["applicableToNetwork"] = applicableToNetwork
        }
        if businessAddress != nil{
            dictionary["businessAddress"] = businessAddress.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        businessId = aDecoder.decodeObject(forKey: "businessId") as? String
        businessName = aDecoder.decodeObject(forKey: "businessName") as? String
        businessPhone = aDecoder.decodeObject(forKey: "businessPhone") as? String
        businessProfilePic = aDecoder.decodeObject(forKey: "businessProfilePic") as? String
        businessAddress = aDecoder.decodeObject(forKey: "businessAddress") as? DealsModelBusinessAddress
        dealId = aDecoder.decodeObject(forKey: "dealId") as? String
        dealName = aDecoder.decodeObject(forKey: "dealName") as? String
        dealDescription = aDecoder.decodeObject(forKey: "dealDescription") as? String
        dealImageUrl = aDecoder.decodeObject(forKey: "dealImageUrl") as? AnyObject
        dealCode = aDecoder.decodeObject(forKey: "dealCode") as? String
        startDate = aDecoder.decodeObject(forKey: "startDate") as? String
        endDate = aDecoder.decodeObject(forKey: "endDate") as? String
        publishingCriteria = aDecoder.decodeObject(forKey: "publishingCriteria") as? String
        criteriaValue = aDecoder.decodeObject(forKey: "criteriaValue") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        publishedDate = aDecoder.decodeObject(forKey: "publishedDate") as? AnyObject
        applicableToNetwork = aDecoder.decodeObject(forKey: "applicableToNetwork") as? Bool
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if businessId != nil{
            aCoder.encode(businessId, forKey: "businessId")
        }
        if businessName != nil{
            aCoder.encode(businessName, forKey: "businessName")
        }
        if businessPhone != nil{
            aCoder.encode(businessPhone, forKey: "businessPhone")
        }
        if businessProfilePic != nil{
            aCoder.encode(businessProfilePic, forKey: "businessProfilePic")
        }
        if businessAddress != nil{
            aCoder.encode(businessAddress, forKey: "businessAddress")
        }
        if dealId != nil{
            aCoder.encode(dealId, forKey: "dealId")
        }
        if dealName != nil{
            aCoder.encode(dealName, forKey: "dealName")
        }
        if dealDescription != nil{
            aCoder.encode(dealDescription, forKey: "dealDescription")
        }
        if dealImageUrl != nil{
            aCoder.encode(dealImageUrl, forKey: "dealImageUrl")
        }
        if dealCode != nil{
            aCoder.encode(dealCode, forKey: "dealCode")
        }
        if startDate != nil{
            aCoder.encode(startDate, forKey: "startDate")
        }
        if endDate != nil{
            aCoder.encode(endDate, forKey: "endDate")
        }
        if publishingCriteria != nil{
            aCoder.encode(publishingCriteria, forKey: "publishingCriteria")
        }
        if criteriaValue != nil{
            aCoder.encode(criteriaValue, forKey: "criteriaValue")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if publishedDate != nil{
            aCoder.encode(publishedDate, forKey: "publishedDate")
        }
        if applicableToNetwork != nil{
            aCoder.encode(applicableToNetwork, forKey: "applicableToNetwork")
        }
    }
}
