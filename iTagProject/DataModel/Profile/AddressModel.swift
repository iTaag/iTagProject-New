//
//  AddressModel.swift
//  iTagProject
//
//  Created by Swapna Botta on 01/06/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import Foundation
struct AddressData {
    
    var pincode : String!
    var city : String!
    var streetName : String!
    init(zipName: String, sublocalityName: String, localityName: String) {
        self.pincode = zipName
        self.streetName = sublocalityName
        self.city = localityName
    }
}

//zipName: String?
//var localityName: String?
//var sublocalityName: String?
//
//var addressId : String!
//var addressName : String!
//var userId : String!
//var pincode : String!
//var city : String!
//var streetName : String!
//var houseNo : String!
//var buildingName : String!
//var apartmentNumber : String!
//var colony : String!
//var landMark : String!
//var state : String!
//var status : String!
//var type : String!
//var dateCreated : String!
//var dateModified : String!
