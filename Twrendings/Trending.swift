//
//  Trending.swift
//  Twrendings
//
//  Created by 徐承維 on 2020/2/21.
//  Copyright © 2020 徐承維. All rights reserved.
//

import Foundation

struct Trending : Codable {
    let trends : [Trend]
    let as_of : Date
    let created_at : Date
    let locations : [Location]?
}

struct Trend : Codable{
    let name : String
    let url : String
    let promoted_content : String?
    let query : String?
    var tweet_volume : Int?
}

enum Value : String {
    case Bearer = "Bearer AAAAAAAAAAAAAAAAAAAAAB%2BQCgEAAAAAynBwC3ChffLP0f4WU1b%2BioFVY08%3DpQZ4hXIsauygINgAzAZ7NsrzL0wGPxJRhSvYOJC0P28lpkTsfM"
    case Authorization = "Authorization"
}
