//
//  EventsModelLocation.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 14, 2019

import Foundation


class EventsModelLocation : NSObject, NSCoding{

    var longitude : Float!
    var latitude : Float!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        longitude = dictionary["longitude"] as? Float
        latitude = dictionary["latitude"] as? Float
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        longitude = aDecoder.decodeObject(forKey: "longitude") as? Float
        latitude = aDecoder.decodeObject(forKey: "latitude") as? Float
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
    }
}