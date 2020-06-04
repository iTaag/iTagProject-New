//
//  CampsModelCampaign.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 30, 2019

import Foundation


class CampsModelCampaign : NSObject, NSCoding{

    var businessId : String!
    var businessName : String!
    var businessPhone : String!
    var businessProfilePic : String!
    var businessAddress : CampsModelBusinessAddress!
    var campaignId : String!
    var campaignName : String!
    var campaignDescription : String!
    var campaignImageUrl : AnyObject!
    var campaignCode : String!
    var startDate : String!
    var endDate : String!
    var rewardPolicyId : String!
    var redeemPolicyId : String!
    var publishingCriteria : String!
    var criteriaValue : String!
    var status : String!
    var publishedDate : String!
    var applicableToNetwork : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        businessId = dictionary["businessId"] as? String
        businessName = dictionary["businessName"] as? String
        businessPhone = dictionary["businessPhone"] as? String
        businessProfilePic = dictionary["businessProfilePic"] as? String
        campaignId = dictionary["campaignId"] as? String
        campaignName = dictionary["campaignName"] as? String
        campaignDescription = dictionary["campaignDescription"] as? String
        campaignImageUrl = dictionary["campaignImageUrl"] as? AnyObject
        campaignCode = dictionary["campaignCode"] as? String
        startDate = dictionary["startDate"] as? String
        endDate = dictionary["endDate"] as? String
        rewardPolicyId = dictionary["rewardPolicyId"] as? String
        redeemPolicyId = dictionary["redeemPolicyId"] as? String
        publishingCriteria = dictionary["publishingCriteria"] as? String
        criteriaValue = dictionary["criteriaValue"] as? String
        status = dictionary["status"] as? String
        publishedDate = dictionary["publishedDate"] as? String
        applicableToNetwork = dictionary["applicableToNetwork"] as? Bool
        if let businessAddressData = dictionary["businessAddress"] as? [String:Any]{
            businessAddress = CampsModelBusinessAddress(fromDictionary: businessAddressData)
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
        if campaignId != nil{
            dictionary["campaignId"] = campaignId
        }
        if campaignName != nil{
            dictionary["campaignName"] = campaignName
        }
        if campaignDescription != nil{
            dictionary["campaignDescription"] = campaignDescription
        }
        if campaignImageUrl != nil{
            dictionary["campaignImageUrl"] = campaignImageUrl
        }
        if campaignCode != nil{
            dictionary["campaignCode"] = campaignCode
        }
        if startDate != nil{
            dictionary["startDate"] = startDate
        }
        if endDate != nil{
            dictionary["endDate"] = endDate
        }
        if rewardPolicyId != nil{
            dictionary["rewardPolicyId"] = rewardPolicyId
        }
        if redeemPolicyId != nil{
            dictionary["redeemPolicyId"] = redeemPolicyId
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
        businessAddress = aDecoder.decodeObject(forKey: "businessAddress") as? CampsModelBusinessAddress
        campaignId = aDecoder.decodeObject(forKey: "campaignId") as? String
        campaignName = aDecoder.decodeObject(forKey: "campaignName") as? String
        campaignDescription = aDecoder.decodeObject(forKey: "campaignDescription") as? String
        campaignImageUrl = aDecoder.decodeObject(forKey: "campaignImageUrl") as? AnyObject
        campaignCode = aDecoder.decodeObject(forKey: "campaignCode") as? String
        startDate = aDecoder.decodeObject(forKey: "startDate") as? String
        endDate = aDecoder.decodeObject(forKey: "endDate") as? String
        rewardPolicyId = aDecoder.decodeObject(forKey: "rewardPolicyId") as? String
        redeemPolicyId = aDecoder.decodeObject(forKey: "redeemPolicyId") as? String
        publishingCriteria = aDecoder.decodeObject(forKey: "publishingCriteria") as? String
        criteriaValue = aDecoder.decodeObject(forKey: "criteriaValue") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        publishedDate = aDecoder.decodeObject(forKey: "publishedDate") as? String
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
        if campaignId != nil{
            aCoder.encode(campaignId, forKey: "campaignId")
        }
        if campaignName != nil{
            aCoder.encode(campaignName, forKey: "campaignName")
        }
        if campaignDescription != nil{
            aCoder.encode(campaignDescription, forKey: "campaignDescription")
        }
        if campaignImageUrl != nil{
            aCoder.encode(campaignImageUrl, forKey: "campaignImageUrl")
        }
        if campaignCode != nil{
            aCoder.encode(campaignCode, forKey: "campaignCode")
        }
        if startDate != nil{
            aCoder.encode(startDate, forKey: "startDate")
        }
        if endDate != nil{
            aCoder.encode(endDate, forKey: "endDate")
        }
        if rewardPolicyId != nil{
            aCoder.encode(rewardPolicyId, forKey: "rewardPolicyId")
        }
        if redeemPolicyId != nil{
            aCoder.encode(redeemPolicyId, forKey: "redeemPolicyId")
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