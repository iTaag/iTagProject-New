//
//  ProfileModel .swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 30, 2019

import Foundation


class ProfileModel  : NSObject, NSCoding{

    var userId : String!
    var userType : String!
    var rewards : Int!
    var itaagRewards : Int!
    var phone : String!
    var firstName : String!
    var lastName : String!
    var email : String!
    var gender : String!
    var ageGroup : String!
    var status : String!
    var profileImageUrl : String!
    var referralUrl : String!
    var isTaggedWithRequestor : Bool!
    var taggedAddressIds : [AnyObject]!
    var pinGenerated : Bool!
    var dateCreated : Int!
    var dateModified : Int!
    var isFCMTokenAvailable : Bool!
    var relationShip : AnyObject!
    var relationShipName : AnyObject!
    var locationBroadcast : Bool!
    var publicBroadcast : Bool!
    var userAddresses : [ProfileModelUserAddress]!
    var taggedWithRequestor : Bool!
    var fcmtokenAvailable : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        userId = dictionary["userId"] as? String
        userType = dictionary["userType"] as? String
        rewards = dictionary["rewards"] as? Int
        itaagRewards = dictionary["itaagRewards"] as? Int
        phone = dictionary["phone"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        email = dictionary["email"] as? String
        gender = dictionary["gender"] as? String
        ageGroup = dictionary["ageGroup"] as? String
        status = dictionary["status"] as? String
        profileImageUrl = dictionary["profileImageUrl"] as? String
        referralUrl = dictionary["referralUrl"] as? String
        isTaggedWithRequestor = dictionary["isTaggedWithRequestor"] as? Bool
        pinGenerated = dictionary["pinGenerated"] as? Bool
        dateCreated = dictionary["dateCreated"] as? Int
        dateModified = dictionary["dateModified"] as? Int
        isFCMTokenAvailable = dictionary["isFCMTokenAvailable"] as? Bool
        relationShip = dictionary["relationShip"] as? AnyObject
        relationShipName = dictionary["relationShipName"] as? AnyObject
        locationBroadcast = dictionary["locationBroadcast"] as? Bool
        publicBroadcast = dictionary["publicBroadcast"] as? Bool
        taggedWithRequestor = dictionary["taggedWithRequestor"] as? Bool
        fcmtokenAvailable = dictionary["fcmtokenAvailable"] as? Bool
        userAddresses = [ProfileModelUserAddress]()
        if let userAddressesArray = dictionary["userAddresses"] as? [[String:Any]]{
            for dic in userAddressesArray{
                let value = ProfileModelUserAddress(fromDictionary: dic)
                userAddresses.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if userId != nil{
            dictionary["userId"] = userId
        }
        if userType != nil{
            dictionary["userType"] = userType
        }
        if rewards != nil{
            dictionary["rewards"] = rewards
        }
        if itaagRewards != nil{
            dictionary["itaagRewards"] = itaagRewards
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if firstName != nil{
            dictionary["firstName"] = firstName
        }
        if lastName != nil{
            dictionary["lastName"] = lastName
        }
        if email != nil{
            dictionary["email"] = email
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if ageGroup != nil{
            dictionary["ageGroup"] = ageGroup
        }
        if status != nil{
            dictionary["status"] = status
        }
        if profileImageUrl != nil{
            dictionary["profileImageUrl"] = profileImageUrl
        }
        if referralUrl != nil{
            dictionary["referralUrl"] = referralUrl
        }
        if isTaggedWithRequestor != nil{
            dictionary["isTaggedWithRequestor"] = isTaggedWithRequestor
        }
        if pinGenerated != nil{
            dictionary["pinGenerated"] = pinGenerated
        }
        if dateCreated != nil{
            dictionary["dateCreated"] = dateCreated
        }
        if dateModified != nil{
            dictionary["dateModified"] = dateModified
        }
        if isFCMTokenAvailable != nil{
            dictionary["isFCMTokenAvailable"] = isFCMTokenAvailable
        }
        if relationShip != nil{
            dictionary["relationShip"] = relationShip
        }
        if relationShipName != nil{
            dictionary["relationShipName"] = relationShipName
        }
        if locationBroadcast != nil{
            dictionary["locationBroadcast"] = locationBroadcast
        }
        if publicBroadcast != nil{
            dictionary["publicBroadcast"] = publicBroadcast
        }
        if taggedWithRequestor != nil{
            dictionary["taggedWithRequestor"] = taggedWithRequestor
        }
        if fcmtokenAvailable != nil{
            dictionary["fcmtokenAvailable"] = fcmtokenAvailable
        }
        if userAddresses != nil{
            var dictionaryElements = [[String:Any]]()
            for userAddressesElement in userAddresses {
                dictionaryElements.append(userAddressesElement.toDictionary())
            }
            dictionary["userAddresses"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        userId = aDecoder.decodeObject(forKey: "userId") as? String
        userType = aDecoder.decodeObject(forKey: "userType") as? String
        rewards = aDecoder.decodeObject(forKey: "rewards") as? Int
        itaagRewards = aDecoder.decodeObject(forKey: "itaagRewards") as? Int
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String
        ageGroup = aDecoder.decodeObject(forKey: "ageGroup") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        profileImageUrl = aDecoder.decodeObject(forKey: "profileImageUrl") as? String
        referralUrl = aDecoder.decodeObject(forKey: "referralUrl") as? String
        isTaggedWithRequestor = aDecoder.decodeObject(forKey: "isTaggedWithRequestor") as? Bool
        taggedAddressIds = aDecoder.decodeObject(forKey: "taggedAddressIds") as? [AnyObject]
        pinGenerated = aDecoder.decodeObject(forKey: "pinGenerated") as? Bool
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? Int
        dateModified = aDecoder.decodeObject(forKey: "dateModified") as? Int
        isFCMTokenAvailable = aDecoder.decodeObject(forKey: "isFCMTokenAvailable") as? Bool
        relationShip = aDecoder.decodeObject(forKey: "relationShip") as? AnyObject
        relationShipName = aDecoder.decodeObject(forKey: "relationShipName") as? AnyObject
        locationBroadcast = aDecoder.decodeObject(forKey: "locationBroadcast") as? Bool
        publicBroadcast = aDecoder.decodeObject(forKey: "publicBroadcast") as? Bool
        userAddresses = aDecoder.decodeObject(forKey: "userAddresses") as? [ProfileModelUserAddress]
        taggedWithRequestor = aDecoder.decodeObject(forKey: "taggedWithRequestor") as? Bool
        fcmtokenAvailable = aDecoder.decodeObject(forKey: "fcmtokenAvailable") as? Bool
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if userType != nil{
            aCoder.encode(userType, forKey: "userType")
        }
        if rewards != nil{
            aCoder.encode(rewards, forKey: "rewards")
        }
        if itaagRewards != nil{
            aCoder.encode(itaagRewards, forKey: "itaagRewards")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "firstName")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "lastName")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        if ageGroup != nil{
            aCoder.encode(ageGroup, forKey: "ageGroup")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if profileImageUrl != nil{
            aCoder.encode(profileImageUrl, forKey: "profileImageUrl")
        }
        if referralUrl != nil{
            aCoder.encode(referralUrl, forKey: "referralUrl")
        }
        if isTaggedWithRequestor != nil{
            aCoder.encode(isTaggedWithRequestor, forKey: "isTaggedWithRequestor")
        }
        if taggedAddressIds != nil{
            aCoder.encode(taggedAddressIds, forKey: "taggedAddressIds")
        }
        if pinGenerated != nil{
            aCoder.encode(pinGenerated, forKey: "pinGenerated")
        }
        if dateCreated != nil{
            aCoder.encode(dateCreated, forKey: "dateCreated")
        }
        if dateModified != nil{
            aCoder.encode(dateModified, forKey: "dateModified")
        }
        if isFCMTokenAvailable != nil{
            aCoder.encode(isFCMTokenAvailable, forKey: "isFCMTokenAvailable")
        }
        if relationShip != nil{
            aCoder.encode(relationShip, forKey: "relationShip")
        }
        if relationShipName != nil{
            aCoder.encode(relationShipName, forKey: "relationShipName")
        }
        if locationBroadcast != nil{
            aCoder.encode(locationBroadcast, forKey: "locationBroadcast")
        }
        if publicBroadcast != nil{
            aCoder.encode(publicBroadcast, forKey: "publicBroadcast")
        }
        if userAddresses != nil{
            aCoder.encode(userAddresses, forKey: "userAddresses")
        }
        if taggedWithRequestor != nil{
            aCoder.encode(taggedWithRequestor, forKey: "taggedWithRequestor")
        }
        if fcmtokenAvailable != nil{
            aCoder.encode(fcmtokenAvailable, forKey: "fcmtokenAvailable")
        }
    }
}

