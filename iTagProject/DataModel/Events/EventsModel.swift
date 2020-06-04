

import Foundation

class EventsModel : NSObject, NSCoding {

    var events : [EventsModelEvent]!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        events = [EventsModelEvent]()
        if let eventsArray = dictionary["Events"] as? [[String:Any]]{
            for dic in eventsArray{
                let value = EventsModelEvent(fromDictionary: dic)
                events.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if events != nil{
            var dictionaryElements = [[String:Any]]()
            for eventsElement in events {
                dictionaryElements.append(eventsElement.toDictionary())
            }
            dictionary["events"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        events = aDecoder.decodeObject(forKey: "Events") as? [EventsModelEvent]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if events != nil {
            aCoder.encode(events, forKey: "Events")
        }
    }
}
