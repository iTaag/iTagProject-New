//
//  DealsModel .swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 22, 2019

import Foundation


class DealsModel  : NSObject, NSCoding{

    var deals : [DealsModelDeal]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        deals = [DealsModelDeal]()
        if let dealsArray = dictionary["Deals"] as? [[String:Any]]{
            for dic in dealsArray{
                let value = DealsModelDeal(fromDictionary: dic)
                deals.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if deals != nil{
            var dictionaryElements = [[String:Any]]()
            for dealsElement in deals {
                dictionaryElements.append(dealsElement.toDictionary())
            }
            dictionary["deals"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        deals = aDecoder.decodeObject(forKey: "Deals") as? [DealsModelDeal]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if deals != nil{
            aCoder.encode(deals, forKey: "Deals")
        }
    }
}