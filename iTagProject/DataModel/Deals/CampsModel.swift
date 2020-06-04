//
//  CampsModel .swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 30, 2019

import Foundation


class CampsModel  : NSObject, NSCoding{

    var campaigns : [CampsModelCampaign]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        campaigns = [CampsModelCampaign]()
        if let campaignsArray = dictionary["Campaigns"] as? [[String:Any]]{
            for dic in campaignsArray{
                let value = CampsModelCampaign(fromDictionary: dic)
                campaigns.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if campaigns != nil{
            var dictionaryElements = [[String:Any]]()
            for campaignsElement in campaigns {
                dictionaryElements.append(campaignsElement.toDictionary())
            }
            dictionary["campaigns"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        campaigns = aDecoder.decodeObject(forKey: "Campaigns") as? [CampsModelCampaign]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if campaigns != nil{
            aCoder.encode(campaigns, forKey: "Campaigns")
        }
    }
}