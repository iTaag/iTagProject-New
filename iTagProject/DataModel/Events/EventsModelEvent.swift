

import Foundation

class EventsModelEvent : NSObject, NSCoding {

    var eventId : String!
    var eventOwnerName : AnyObject!
    var eventOwnerProfilePic : AnyObject!
    var eventName : String!
    var eventMessage : String!
    var eventImageUrl : AnyObject!
    var eventDate : String!
    var eventTime : String!
    var eventEndDate : String!
    var eventEndTime : String!
    var isAllDayEvent : Bool!
    var isEventRepeatable : Bool!
    var eventAddress : String!
    var eventCity : String!
    var location : EventsModelLocation!
    var remindersList : [String]!
    var participantType : AnyObject!
    var type : String!
    var eventType : String!
    var inviteeType : String!
    var eventFrequency : String!
    var numberOfOccurrences : AnyObject!
    var status : String!
    var scheduledDate : String!
    var groupId : AnyObject!
    var showGuests : Bool!
    var createGroup : Bool!
    var recurringdates : [AnyObject]!
    var guestList : [EventsModelGuestList]!
    var invitedCount : Int!
    var acceptedCount : Int!
    var maybeCount : Int!
    var declinedCount : Int!
    var notRespondedCount : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        eventId = dictionary["eventId"] as? String
        eventOwnerName = dictionary["eventOwnerName"] as? AnyObject
        eventOwnerProfilePic = dictionary["eventOwnerProfilePic"] as? AnyObject
        eventName = dictionary["eventName"] as? String
        eventMessage = dictionary["eventMessage"] as? String
        eventImageUrl = dictionary["eventImageUrl"] as? AnyObject
        eventDate = dictionary["eventDate"] as? String
        eventTime = dictionary["eventTime"] as? String
        eventEndDate = dictionary["eventEndDate"] as? String
        eventEndTime = dictionary["eventEndTime"] as? String
        isAllDayEvent = dictionary["isAllDayEvent"] as? Bool
        isEventRepeatable = dictionary["isEventRepeatable"] as? Bool
        eventAddress = dictionary["eventAddress"] as? String
        eventCity = dictionary["eventCity"] as? String
        participantType = dictionary["participantType"] as? AnyObject
        type = dictionary["type"] as? String
        eventType = dictionary["eventType"] as? String
        inviteeType = dictionary["inviteeType"] as? String
        eventFrequency = dictionary["eventFrequency"] as? String
        numberOfOccurrences = dictionary["numberOfOccurrences"] as? AnyObject
        status = dictionary["status"] as? String
        scheduledDate = dictionary["scheduledDate"] as? String
        groupId = dictionary["groupId"] as? AnyObject
        showGuests = dictionary["showGuests"] as? Bool
        createGroup = dictionary["createGroup"] as? Bool
        invitedCount = dictionary["invitedCount"] as? Int
        acceptedCount = dictionary["acceptedCount"] as? Int
        maybeCount = dictionary["maybeCount"] as? Int
        declinedCount = dictionary["declinedCount"] as? Int
        notRespondedCount = dictionary["notRespondedCount"] as? Int
        if let locationData = dictionary["location"] as? [String:Any]{
            location = EventsModelLocation(fromDictionary: locationData)
        }
        guestList = [EventsModelGuestList]()
        if let guestListArray = dictionary["guestList"] as? [[String:Any]]{
            for dic in guestListArray{
                let value = EventsModelGuestList(fromDictionary: dic)
                guestList.append(value)
            }
        }
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
        if eventOwnerName != nil{
            dictionary["eventOwnerName"] = eventOwnerName
        }
        if eventOwnerProfilePic != nil{
            dictionary["eventOwnerProfilePic"] = eventOwnerProfilePic
        }
        if eventName != nil{
            dictionary["eventName"] = eventName
        }
        if eventMessage != nil{
            dictionary["eventMessage"] = eventMessage
        }
        if eventImageUrl != nil{
            dictionary["eventImageUrl"] = eventImageUrl
        }
        if eventDate != nil{
            dictionary["eventDate"] = eventDate
        }
        if eventTime != nil{
            dictionary["eventTime"] = eventTime
        }
        if eventEndDate != nil{
            dictionary["eventEndDate"] = eventEndDate
        }
        if eventEndTime != nil{
            dictionary["eventEndTime"] = eventEndTime
        }
        if isAllDayEvent != nil{
            dictionary["isAllDayEvent"] = isAllDayEvent
        }
        if isEventRepeatable != nil{
            dictionary["isEventRepeatable"] = isEventRepeatable
        }
        if eventAddress != nil{
            dictionary["eventAddress"] = eventAddress
        }
        if eventCity != nil{
            dictionary["eventCity"] = eventCity
        }
        if participantType != nil{
            dictionary["participantType"] = participantType
        }
        if type != nil{
            dictionary["type"] = type
        }
        if eventType != nil{
            dictionary["eventType"] = eventType
        }
        if inviteeType != nil{
            dictionary["inviteeType"] = inviteeType
        }
        if eventFrequency != nil{
            dictionary["eventFrequency"] = eventFrequency
        }
        if numberOfOccurrences != nil{
            dictionary["numberOfOccurrences"] = numberOfOccurrences
        }
        if status != nil{
            dictionary["status"] = status
        }
        if scheduledDate != nil{
            dictionary["scheduledDate"] = scheduledDate
        }
        if groupId != nil{
            dictionary["groupId"] = groupId
        }
        if showGuests != nil{
            dictionary["showGuests"] = showGuests
        }
        if createGroup != nil{
            dictionary["createGroup"] = createGroup
        }
        if invitedCount != nil{
            dictionary["invitedCount"] = invitedCount
        }
        if acceptedCount != nil{
            dictionary["acceptedCount"] = acceptedCount
        }
        if maybeCount != nil{
            dictionary["maybeCount"] = maybeCount
        }
        if declinedCount != nil{
            dictionary["declinedCount"] = declinedCount
        }
        if notRespondedCount != nil{
            dictionary["notRespondedCount"] = notRespondedCount
        }
        if location != nil{
            dictionary["location"] = location.toDictionary()
        }
        if guestList != nil{
            var dictionaryElements = [[String:Any]]()
            for guestListElement in guestList {
                dictionaryElements.append(guestListElement.toDictionary())
            }
            dictionary["guestList"] = dictionaryElements
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
        eventOwnerName = aDecoder.decodeObject(forKey: "eventOwnerName") as? AnyObject
        eventOwnerProfilePic = aDecoder.decodeObject(forKey: "eventOwnerProfilePic") as? AnyObject
        eventName = aDecoder.decodeObject(forKey: "eventName") as? String
        eventMessage = aDecoder.decodeObject(forKey: "eventMessage") as? String
        eventImageUrl = aDecoder.decodeObject(forKey: "eventImageUrl") as? AnyObject
        eventDate = aDecoder.decodeObject(forKey: "eventDate") as? String
        eventTime = aDecoder.decodeObject(forKey: "eventTime") as? String
        eventEndDate = aDecoder.decodeObject(forKey: "eventEndDate") as? String
        eventEndTime = aDecoder.decodeObject(forKey: "eventEndTime") as? String
        isAllDayEvent = aDecoder.decodeObject(forKey: "isAllDayEvent") as? Bool
        isEventRepeatable = aDecoder.decodeObject(forKey: "isEventRepeatable") as? Bool
        eventAddress = aDecoder.decodeObject(forKey: "eventAddress") as? String
        eventCity = aDecoder.decodeObject(forKey: "eventCity") as? String
        location = aDecoder.decodeObject(forKey: "location") as? EventsModelLocation
        remindersList = aDecoder.decodeObject(forKey: "remindersList") as? [String]
        participantType = aDecoder.decodeObject(forKey: "participantType") as? AnyObject
        type = aDecoder.decodeObject(forKey: "type") as? String
        eventType = aDecoder.decodeObject(forKey: "eventType") as? String
        inviteeType = aDecoder.decodeObject(forKey: "inviteeType") as? String
        eventFrequency = aDecoder.decodeObject(forKey: "eventFrequency") as? String
        numberOfOccurrences = aDecoder.decodeObject(forKey: "numberOfOccurrences") as? AnyObject
        status = aDecoder.decodeObject(forKey: "status") as? String
        scheduledDate = aDecoder.decodeObject(forKey: "scheduledDate") as? String
        groupId = aDecoder.decodeObject(forKey: "groupId") as? AnyObject
        showGuests = aDecoder.decodeObject(forKey: "showGuests") as? Bool
        createGroup = aDecoder.decodeObject(forKey: "createGroup") as? Bool
        recurringdates = aDecoder.decodeObject(forKey: "recurringdates") as? [AnyObject]
        guestList = aDecoder.decodeObject(forKey: "guestList") as? [EventsModelGuestList]
        invitedCount = aDecoder.decodeObject(forKey: "invitedCount") as? Int
        acceptedCount = aDecoder.decodeObject(forKey: "acceptedCount") as? Int
        maybeCount = aDecoder.decodeObject(forKey: "maybeCount") as? Int
        declinedCount = aDecoder.decodeObject(forKey: "declinedCount") as? Int
        notRespondedCount = aDecoder.decodeObject(forKey: "notRespondedCount") as? Int
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
        if eventOwnerName != nil{
            aCoder.encode(eventOwnerName, forKey: "eventOwnerName")
        }
        if eventOwnerProfilePic != nil{
            aCoder.encode(eventOwnerProfilePic, forKey: "eventOwnerProfilePic")
        }
        if eventName != nil{
            aCoder.encode(eventName, forKey: "eventName")
        }
        if eventMessage != nil{
            aCoder.encode(eventMessage, forKey: "eventMessage")
        }
        if eventImageUrl != nil{
            aCoder.encode(eventImageUrl, forKey: "eventImageUrl")
        }
        if eventDate != nil{
            aCoder.encode(eventDate, forKey: "eventDate")
        }
        if eventTime != nil{
            aCoder.encode(eventTime, forKey: "eventTime")
        }
        if eventEndDate != nil{
            aCoder.encode(eventEndDate, forKey: "eventEndDate")
        }
        if eventEndTime != nil{
            aCoder.encode(eventEndTime, forKey: "eventEndTime")
        }
        if isAllDayEvent != nil{
            aCoder.encode(isAllDayEvent, forKey: "isAllDayEvent")
        }
        if isEventRepeatable != nil{
            aCoder.encode(isEventRepeatable, forKey: "isEventRepeatable")
        }
        if eventAddress != nil{
            aCoder.encode(eventAddress, forKey: "eventAddress")
        }
        if eventCity != nil{
            aCoder.encode(eventCity, forKey: "eventCity")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if remindersList != nil{
            aCoder.encode(remindersList, forKey: "remindersList")
        }
        if participantType != nil{
            aCoder.encode(participantType, forKey: "participantType")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if eventType != nil{
            aCoder.encode(eventType, forKey: "eventType")
        }
        if inviteeType != nil{
            aCoder.encode(inviteeType, forKey: "inviteeType")
        }
        if eventFrequency != nil{
            aCoder.encode(eventFrequency, forKey: "eventFrequency")
        }
        if numberOfOccurrences != nil{
            aCoder.encode(numberOfOccurrences, forKey: "numberOfOccurrences")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if scheduledDate != nil{
            aCoder.encode(scheduledDate, forKey: "scheduledDate")
        }
        if groupId != nil{
            aCoder.encode(groupId, forKey: "groupId")
        }
        if showGuests != nil{
            aCoder.encode(showGuests, forKey: "showGuests")
        }
        if createGroup != nil{
            aCoder.encode(createGroup, forKey: "createGroup")
        }
        if recurringdates != nil{
            aCoder.encode(recurringdates, forKey: "recurringdates")
        }
        if guestList != nil{
            aCoder.encode(guestList, forKey: "guestList")
        }
        if invitedCount != nil{
            aCoder.encode(invitedCount, forKey: "invitedCount")
        }
        if acceptedCount != nil{
            aCoder.encode(acceptedCount, forKey: "acceptedCount")
        }
        if maybeCount != nil{
            aCoder.encode(maybeCount, forKey: "maybeCount")
        }
        if declinedCount != nil{
            aCoder.encode(declinedCount, forKey: "declinedCount")
        }
        if notRespondedCount != nil{
            aCoder.encode(notRespondedCount, forKey: "notRespondedCount")
        }
    }
}
