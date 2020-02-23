//
//  Location.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/21.
//  Copyright © 2020 徐承維. All rights reserved.
//

import Foundation

struct Location : Codable {
    var name : String?
    var woeid : Int
    var placeType : PlaceType?
    var country : String?
    var url : String?
    var countryCode : String?
    var parentid : Int?
}

struct PlaceType : Codable {
    let name : String?
    let code : Int
}




